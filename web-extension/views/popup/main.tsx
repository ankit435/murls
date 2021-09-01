import { render } from "preact";
import { Auth0Provider } from "@auth0/auth0-react";
import { Box, CssBaseline } from "@material-ui/core";

import TabBar from "./TabBar";
import AllUrls from "./AllUrls";
import AddUrl from "./AddUrl";
import Recyles from "./RecycledUrls";
import MyAccount from "./MyAccount";
import { getAuth0Config } from "../../src/utils/getConfig";

const NewTab = () => {
    return (
        <>
            <Auth0Provider
                domain={getAuth0Config().domain}
                clientId={getAuth0Config().clientId}
                redirectUri={window.location.origin}
            >
                <Box>
                    <CssBaseline />
                    <TabBar
                        allUrls={<AllUrls />}
                        addUrls={<AddUrl />}
                        recycleUrls={<Recyles />}
                        myAccount={<MyAccount />}
                    />
                </Box>
            </Auth0Provider>
        </>
    );
};

render(<NewTab />, document.getElementById("root")!);
