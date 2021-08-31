import { useEffect, useState } from "preact/hooks";
import { AppBar, Tabs, Tab } from "@material-ui/core";
import { useAuth0 } from "@auth0/auth0-react";

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
    recycleUrls: JSX.Element;
    myAccount: JSX.Element;
}

export default function TabBar({
    addUrls,
    allUrls,
    recycleUrls,
    myAccount,
}: ITabBarProps) {
    const [tabBarIndex, setTabBarIndex] = useState(0);
    const [disabled, setDisabled] = useState(false);
    const { isLoading, isAuthenticated, getAccessTokenSilently } = useAuth0();

    const handleChange = (event: React.ChangeEvent<{}>, newValue: number) => {
        setTabBarIndex(newValue);
    };

    useEffect(() => {
        const loginInAfterPopup = async () => {
            const token = await getAccessTokenSilently();
            if (token && token.length > 0) {
                setDisabled(false);
                setTabBarIndex((prevState) =>
                    prevState === 3 ? 0 : prevState
                );
            }
        };
        loginInAfterPopup();
    }, []);

    useEffect(() => {
        if (!isLoading && !isAuthenticated) {
            setDisabled(true);
            setTabBarIndex(3);
        }
    }, [isLoading, isAuthenticated]);

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
                    <Tab disabled={disabled} label="New" {...a11yProps(0)} />
                    <Tab
                        disabled={disabled}
                        label="My URLs"
                        {...a11yProps(1)}
                    />
                    <Tab
                        disabled={disabled}
                        label="Recyled"
                        {...a11yProps(2)}
                    />
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
                {recycleUrls}
            </TabPanel>
            <TabPanel value={tabBarIndex} index={3}>
                {myAccount}
            </TabPanel>
        </>
    );
}
