import { render } from "preact";
import { browser } from "webextension-polyfill-ts";
import {Button,Box,TextField,createStyles,makeStyles} from '@material-ui/core'

const useStyles = makeStyles((theme) =>
  createStyles({
    root: {
      '& > *': {
        margin: theme.spacing(1),
      },
    },
    input: {
      display: 'none',
    },
  }),
);

const NewTab = () => {
  const classes = useStyles();
  
  const openOptionPage = () => {
    browser.runtime.openOptionsPage();
  };
  return (
    <Box className={classes.root}>
      <TextField label="Enter Alias" variant="outlined" />
      <Button color="primary" variant="contained" onClick={openOptionPage}>Murl It!</Button>
    </Box>
  );
};

render(<NewTab />, document.getElementById("root")!);
