import { render } from "preact";
import { Box, CssBaseline } from "@material-ui/core";

import TabBar from "./TabBar";
import AllUrls from "./AllUrls";
import AddUrl from "./AddUrl";
import Recyles from "./RecycledUrls";
import MyAccount from "./MyAccount";

const NewTab = () => {
    return (
        <Box>
            <CssBaseline />
            <TabBar
                allUrls={<AllUrls />}
                addUrls={<AddUrl />}
                recycleUrls={<Recyles />}
                myAccount={<MyAccount />}
            />
        </Box>
    );
};

render(<NewTab />, document.getElementById("root")!);
