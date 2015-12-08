package oliva.polytech.polyfeeds;

import android.app.Activity;
import android.app.ListActivity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.bluetooth.le.BluetoothLeScanner;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.support.v4.widget.DrawerLayout;
import android.widget.ArrayAdapter;
import android.widget.CalendarView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity
        implements NavigationDrawerFragment.NavigationDrawerCallbacks {

    /**
     * Fragment managing the behaviors, interactions and presentation of the navigation drawer.
     */
    private NavigationDrawerFragment mNavigationDrawerFragment;

    /**
     * Used to store the last screen title. For use in {@link #restoreActionBar()}.
     */
    private CharSequence mTitle;
    private int num;
    private String[] classLundi = {"Mathematiques\nPEPO - 203\n8h30 - 10h30","Anglais\nDAMBRE - Atrium 226\n13h45 - 15h45"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mNavigationDrawerFragment = (NavigationDrawerFragment)
                getSupportFragmentManager().findFragmentById(R.id.navigation_drawer);
        mTitle = getTitle();

        // Set up the drawer.
        mNavigationDrawerFragment.setUp(
                R.id.navigation_drawer,
                (DrawerLayout) findViewById(R.id.drawer_layout));
        findViewById(R.id.container).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(MainActivity.this, SettingsActivity.class));
            }
        });
    }

    @Override
    public void onNavigationDrawerItemSelected(int position) {
        // update the main content by replacing fragments
        FragmentManager fragmentManager = getSupportFragmentManager();
        fragmentManager.beginTransaction()
                .replace(R.id.container, PlaceholderFragment.newInstance(position + 1, this.classLundi, this))
                .commit();
    }

    public void onSectionAttached(int number) {
        this.num = number;
        switch (number) {
            case 1:
                mTitle = getString(R.string.title_section1);
                break;
            case 2:
                mTitle = getString(R.string.title_section2);
                break;
            case 3:
                mTitle = getString(R.string.title_section3);
                break;
            case 4:
                mTitle = getString(R.string.title_section4);
                break;
        }
    }

    public void restoreActionBar() {
        ActionBar actionBar = getSupportActionBar();
        actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_STANDARD);
        actionBar.setDisplayShowTitleEnabled(true);
        actionBar.setTitle(mTitle);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        if (!mNavigationDrawerFragment.isDrawerOpen()) {
            // Only show items in the action bar relevant to this screen
            // if the drawer is not showing. Otherwise, let the drawer
            // decide what to show in the action bar.
            getMenuInflater().inflate(R.menu.main, menu);
            restoreActionBar();
            return true;
        }
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            //Toast.makeText(this, "Settings", Toast.LENGTH_SHORT).show();
            Intent intentMyAccount = new Intent(getApplicationContext(), SettingsActivity.class);
            startActivity(intentMyAccount);
            return super.onOptionsItemSelected(item);
        } else  if (id == R.id.signin_settings) {
            //Toast.makeText(this, "Settings", Toast.LENGTH_SHORT).show();
            Intent intentMyAccount = new Intent(getApplicationContext(), LoginActivity.class);
            startActivity(intentMyAccount);
            return super.onOptionsItemSelected(item);
        } else  if (id == R.id.BLE_List) {
            //Toast.makeText(this, "Settings", Toast.LENGTH_SHORT).show();
            Intent intentMyAccount = new Intent(getApplicationContext(), BLEScan.class);
            startActivity(intentMyAccount);
            return super.onOptionsItemSelected(item);
        }

        if (id == R.id.action_example) {
            switch(num) {
                case 1:
                    (new NewMessageNotification()).notify(this, "Flux", "Nouvelles activité\nDes Biatchs partout", "Flux", 0);
                    break;
                case 2:
                    (new NewMessageNotification()).notify(this, "Calendrier", "Prochain cours\nMachin - Salle truc", "Cours", 1);
                    break;
                case 3:
                    Toast.makeText(this, "Refresh Notes", Toast.LENGTH_SHORT).show();
                    break;
                case 4:
                    Toast.makeText(this, "Refresh Amis", Toast.LENGTH_SHORT).show();
                    break;
                default:
                    Toast.makeText(this, "Refresh Default", Toast.LENGTH_SHORT).show();
                    break;
            }

            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {
        /**
         * The fragment argument representing the section number for this
         * fragment.
         */
        private static final String ARG_SECTION_NUMBER = "section_number";
        private String classLundi[];
        private String empty[] = {"\n\nAucun Cour\n\n"};
        private MainActivity app;
        /**
         * Returns a new instance of this fragment for the given section
         * number.
         */
        public static PlaceholderFragment newInstance(int sectionNumber, final String[] classLundi, final MainActivity app) {
            PlaceholderFragment fragment = new PlaceholderFragment();
            fragment.classLundi = classLundi;
            fragment.app = app;
            Bundle args = new Bundle();
            args.putInt(ARG_SECTION_NUMBER, sectionNumber);
            fragment.setArguments(args);
            return fragment;
        }

        public PlaceholderFragment() {

        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                                 Bundle savedInstanceState) {
            View rootView;
            ListView calendar[] = new ListView[5];
            switch(getArguments().getInt(ARG_SECTION_NUMBER)) {
                case 1:
                    rootView = inflater.inflate(R.layout.flux, container, false);
                    break;
                case 2:
                    rootView = inflater.inflate(R.layout.calendrier, container, false);
                    calendar[0] = (ListView) rootView.findViewById(R.id.postListViewLundi);
                    calendar[0].setAdapter( new ArrayAdapter<String>(this.getContext(),R.layout.postitem,classLundi));

                    calendar[1] = (ListView) rootView.findViewById(R.id.postListViewMardi);
                    calendar[1].setAdapter(new ArrayAdapter<String>(this.getContext(), R.layout.postitem, empty ));

                    calendar[2] = (ListView) rootView.findViewById(R.id.postListViewMercredi);
                    calendar[2].setAdapter(new ArrayAdapter<String>(this.getContext(), R.layout.postitem, classLundi));

                    calendar[3] = (ListView) rootView.findViewById(R.id.postListViewJeudi);
                    calendar[3].setAdapter(new ArrayAdapter<String>(this.getContext(), R.layout.postitem, classLundi));

                    calendar[4] = (ListView) rootView.findViewById(R.id.postListViewVendredi);
                    calendar[4].setAdapter(new ArrayAdapter<String>(this.getContext(), R.layout.postitem, classLundi));

                    return rootView;
                    //break;
                case 3:
                    rootView = inflater.inflate(R.layout.notes, container, false);
                    break;
                case 4:
                    rootView = inflater.inflate(R.layout.amis, container, false);
                    break;
                default:
                    rootView = inflater.inflate(R.layout.fragment_main, container, false);
                    break;
            }
            return rootView;
        }

        @Override
        public void onAttach(Activity activity) {
            super.onAttach(activity);
            ((MainActivity) activity).onSectionAttached(
                    getArguments().getInt(ARG_SECTION_NUMBER));
        }
    }

}
