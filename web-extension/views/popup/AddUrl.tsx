import { browser } from "webextension-polyfill-ts";

import { useState } from "preact/hooks";
import {
    makeStyles,
    Grid,
    Box,
    TextField,
    Button,
    Checkbox,
    Tooltip,
    FormControlLabel,
    Typography,
} from "@material-ui/core";
import { IoRocket, IoRocketOutline } from "react-icons/io5";

import { AddUrlDataType } from "../../src/types";
import { postUrl } from "../../src/utils/fetchData";

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

interface IHasSubmitted {
    data?: Record<string, unknown>;
}

function HasSubmitted({ data }: IHasSubmitted) {
    const [copied, setCopied] = useState("copy to clipboard");
    return (
        <Box margin="0 2rem">
            {data?.shortened ? (
                <Typography variant="subtitle1">
                    🎉 Murl Was Created:{" "}
                    <Tooltip placement="bottom" title={copied}>
                        <Button
                            onClick={() => {
                                navigator.clipboard.writeText(
                                    data?.shortened as string
                                );
                                setCopied("copied");
                            }}
                        >
                            {data?.shortened as string}
                        </Button>
                    </Tooltip>
                </Typography>
            ) : (
                <Typography variant="subtitle2">
                    {(data?.detail as string) ?? JSON.stringify(data, null, 2)}
                </Typography>
            )}
        </Box>
    );
}

interface IAddUrlProps {
    id?: number;
}

export default function AddUrl(edit: IAddUrlProps = { id: undefined }) {
    const classes = useStyles();

    const [addingUrl, setAddingUrl] = useState<AddUrlDataType>({
        location: "",
        boosted: false,
        slug: "",
        expiry_date: "",
    });
    const [hasSubmitted, setHasSubmitted] = useState<IHasSubmitted>({});

    browser.tabs.query({ active: true, lastFocusedWindow: true }).then((tabs) =>
        setAddingUrl((prevState) => ({
            ...prevState,
            location: Array.isArray(tabs) ? tabs[0]?.url ?? "" : "",
        }))
    );

    const submitAddingUrl = async () => {
        const result = await postUrl(addingUrl);
        setHasSubmitted({ data: result });
    };

    return (
        <>
            <Grid
                container
                justifyContent="center"
                alignItems="center"
                direction="column"
                className={classes.formContainer}
            >
                {hasSubmitted.data ? (
                    <HasSubmitted data={hasSubmitted.data} />
                ) : (
                    <>
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
                                // TODO: change this to expiry date
                                console.log(
                                    "the date value was ",
                                    e.target.value
                                )
                            }
                        />
                        <Button
                            className={classes.submitButton}
                            variant="contained"
                            color="secondary"
                            size="small"
                            onClick={submitAddingUrl}
                        >
                            Murl It
                        </Button>
                    </>
                )}
            </Grid>
        </>
    );
}
