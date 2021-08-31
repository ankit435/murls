import { useState } from "preact/hooks";
import { AppBar, Tabs, Tab } from "@material-ui/core";

interface TabPanelProps {
    children?: React.ReactNode;
    index: any;
    value: any;
}

function TabPanel({ children, value, index, ...rest }: TabPanelProps) {
    return (
        <div
            role="tabpanel"
            hidden={value !== index}
            id={`simple-tabpanel-${index}`}
            aria-labelledby={`simple-tab-${index}`}
            {...rest}
        >
            {value === index && <> {children}</>}
        </div>
    );
}

function a11yProps(index: number) {
    return {
        id: `simple-tab-${index}`,
        "aria-controls": `simple-tabpanel-${index}`,
    };
}

interface ITabBarProps {
    allUrls: JSX.Element;
    addUrls: JSX.Element;
}

export default function TabBar({ addUrls, allUrls }: ITabBarProps) {
    const [tabBarIndex, setTabBarIndex] = useState(0);

    const handleChange = (event: React.ChangeEvent<{}>, newValue: number) => {
        setTabBarIndex(newValue);
    };

    return (
        <>
            <AppBar position="static" color="primary">
                <Tabs
                    value={tabBarIndex}
                    onChange={handleChange}
                    aria-label="murls-extension-tabs"
                    variant="fullWidth"
                    scrollButtons="auto"
                >
                    <Tab label="New" {...a11yProps(0)} />
                    <Tab label="My URLs" {...a11yProps(1)} />
                    <Tab label="Recyled" {...a11yProps(2)} />
                    <Tab label="My Account" {...a11yProps(3)} />
                </Tabs>
            </AppBar>
            <TabPanel value={tabBarIndex} index={0}>
                {addUrls}
            </TabPanel>
            <TabPanel value={tabBarIndex} index={1}>
                {allUrls}
            </TabPanel>
            <TabPanel value={tabBarIndex} index={2}>
                Item Three
            </TabPanel>
            <TabPanel value={tabBarIndex} index={3}>
                Item Four
            </TabPanel>
        </>
    );
}
