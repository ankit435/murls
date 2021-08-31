import { render } from "preact";
import { Box, CssBaseline } from "@material-ui/core";

import TabBar from "./TabBar";
import AllUrls from "./AllUrls";
import AddUrl from "./AddUrl";

const NewTab = () => {
    return (
        <Box>
            <CssBaseline />
            <TabBar allUrls={<AllUrls />} addUrls={<AddUrl />} />
        </Box>
    );
};

render(<NewTab />, document.getElementById("root")!);
