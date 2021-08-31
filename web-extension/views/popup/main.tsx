import { render } from "preact";
import {
    Box,
    createStyles,
    makeStyles,
} from "@material-ui/core";

import TabBar from "./TabBar";
import AllUrls from "./AllUrls";

const useStyles = makeStyles((theme) =>
    createStyles({
        root: {
            "& > *": {
                margin: theme.spacing(1),
            },
        },
    })
);

const NewTab = () => {
    const classes = useStyles();
    return (
        <Box className={classes.root}>
            <TabBar allUrls={<AllUrls />} />
        </Box>
    );
};

render(<NewTab />, document.getElementById("root")!);
