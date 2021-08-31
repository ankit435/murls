import { browser } from "webextension-polyfill-ts";

import { useState } from "preact/hooks";
import {
    makeStyles,
    Grid,
    TextField,
    Button,
    Checkbox,
    FormControlLabel,
} from "@material-ui/core";
import { IoRocket, IoRocketOutline } from "react-icons/io5";

import { UrlDataType } from "../../src/types";

type AddUrlDataType = Pick<
    UrlDataType,
    "slug" | "location" | "boosted" | "expiry_date"
>;

const useStyles = makeStyles((theme) => ({
    formContainer: {
        margin: theme.spacing(2, 0),
    },
    textInput: {
        margin: theme.spacing(1, 0),
    },
    submitButton: {
        margin: theme.spacing(1, 0),
    },
}));

export default function AddUrl() {
    const classes = useStyles();

    const [addingUrl, setAddingUrl] = useState<AddUrlDataType>({
        location: "",
        boosted: false,
        slug: "",
        expiry_date: "",
    });

    browser.tabs.query({ active: true, lastFocusedWindow: true }).then((tabs) =>
        setAddingUrl((prevState) => ({
            ...prevState,
            location: tabs[0].url ?? "",
        }))
    );

    // TODO: location will be auto filled from current urlo

    return (
        <>
            <Grid
                container
                justify="center"
                alignItems="center"
                direction="column"
                className={classes.formContainer}
            >
                <TextField
                    id="alias"
                    label="Alias"
                    variant="outlined"
                    size="small"
                    value={addingUrl.location}
                    className={classes.textInput}
                    onChange={(e) =>
                        setAddingUrl((prevState) => ({
                            ...prevState,
                            location: e.target.value,
                        }))
                    }
                />
                <TextField
                    id="alias"
                    className={classes.textInput}
                    label="Alias"
                    variant="outlined"
                    size="small"
                    value={addingUrl.slug}
                    onChange={(e) =>
                        setAddingUrl((prevState) => ({
                            ...prevState,
                            slug: e.target.value,
                        }))
                    }
                />
                <FormControlLabel
                    control={
                        <Checkbox
                            icon={<IoRocketOutline />}
                            checkedIcon={<IoRocket />}
                            checked={addingUrl.boosted}
                            onChange={(e) =>
                                setAddingUrl((prevState) => ({
                                    ...prevState,
                                    boosted: e.target.checked,
                                }))
                            }
                            name="checkedF"
                        />
                    }
                    label="Boost"
                />
                <TextField
                    id="expiry_date"
                    label="Expiry Date"
                    type="date"
                    className={classes.textInput}
                    size="small"
                    value={addingUrl.expiry_date}
                    InputLabelProps={{
                        shrink: true,
                    }}
                    onChange={(e) =>
                        console.log("the date value was ", e.target.value)
                    }
                />
                <Button
                    className={classes.submitButton}
                    variant="contained"
                    color="secondary"
                    size="small"
                >
                    Murl It
                </Button>
            </Grid>
        </>
    );
}
