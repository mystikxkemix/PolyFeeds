package oliva.polytech.polyfeeds;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothManager;
import android.content.Intent;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.support.v4.widget.DrawerLayout;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity
        implements NavigationDrawerFragment.NavigationDrawerCallbacks {

    /**
     * Fragment managing the behaviors, interactions and presentation of the navigation drawer.
     */
    private NavigationDrawerFragment mNavigationDrawerFragment;
    private LeDeviceListAdapter mLeDeviceListAdapter;
    private BluetoothAdapter mBluetoothAdapter;
    private boolean mScanning;
    private Handler mHandler;
    private static final int REQUEST_ENABLE_BT = 1;
    private EditText usernameField,passwordField;

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

        mHandler = new Handler();
        final BluetoothManager bluetoothManager =
                (BluetoothManager) getSystemService(Context.BLUETOOTH_SERVICE);
        mBluetoothAdapter = bluetoothManager.getAdapter();
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
            //Intent intentMyAccount = new Intent(getApplicationContext(), LoginActivity.class);
            //startActivity(intentMyAccount);

            return super.onOptionsItemSelected(item);
        } else  if (id == R.id.BLE_List) {
//            Toast.makeText(this, "BLE", Toast.LENGTH_SHORT).show();
            mLeDeviceListAdapter = new LeDeviceListAdapter();
            scanLeDevice(true);
            Toast.makeText(this, Integer.toString(mLeDeviceListAdapter.getCount()), Toast.LENGTH_SHORT).show();
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

    @Override
    protected void onResume() {
        super.onResume();
        // Ensures Bluetooth is enabled on the device.  If Bluetooth is not currently enabled,
        // fire an intent to display a dialog asking the user to grant permission to enable it.
        if (!(mBluetoothAdapter==null)) {
            if (!mBluetoothAdapter.isEnabled()) {
                Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT);
            }
        }

        if(mBluetoothAdapter.isEnabled()){

        }

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
    private static final long SCAN_PERIOD = 10000;

    private void scanLeDevice(final boolean enable) {
        if (enable) {
            // Stops scanning after a pre-defined scan period.
            mHandler.postDelayed(new Runnable() {
                @Override
                public void run() {
                    mScanning = false;
                    mBluetoothAdapter.stopLeScan(mLeScanCallback);
                }
            }, SCAN_PERIOD);
            mScanning = true;
            mBluetoothAdapter.startLeScan(mLeScanCallback);
        } else {
            mScanning = false;
            mBluetoothAdapter.stopLeScan(mLeScanCallback);
        }

    }

    private BluetoothAdapter.LeScanCallback mLeScanCallback =
            new BluetoothAdapter.LeScanCallback() {

                @Override
                public void onLeScan(final BluetoothDevice device, int rssi, byte[] scanRecord) {
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            mLeDeviceListAdapter.addDevice(device);
                            mLeDeviceListAdapter.notifyDataSetChanged();
                        }
                    });
                }
            };

}

class LeDeviceListAdapter extends BaseAdapter {
    private ArrayList<BluetoothDevice> mLeDevices;
    private LayoutInflater mInflator;

    public LeDeviceListAdapter() {
        super();
        mLeDevices = new ArrayList<BluetoothDevice>();
    }

    public void addDevice(BluetoothDevice device) {
        if (!mLeDevices.contains(device)) {
            mLeDevices.add(device);
        }
    }

    public BluetoothDevice getDevice(int position) {
        return mLeDevices.get(position);
    }

    public void clear() {
        mLeDevices.clear();
    }

    @Override
    public int getCount() {
        return mLeDevices.size();
    }

    @Override
    public Object getItem(int i) {
        return mLeDevices.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {return view;}

}