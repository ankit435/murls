import { useEffect, useState } from "preact/hooks";
import { MdSettingsBackupRestore } from "react-icons/md";
import { CgTrashEmpty } from "react-icons/cg";
import {
    Box,
    IconButton,
    Paper,
    List,
    ListItem,
    ListItemSecondaryAction,
    ListItemText,
    LinearProgress,
    Typography,
} from "@material-ui/core";

import {
    fetchRecyledUrls,
    deleteRecyledUrl,
    restoreRecyledUrl,
} from "../../src/utils/fetchData";
import { RecyledUrlDataType } from "../../src/types/index";

export default function AllRecycles() {
    const [recycles, setRecyles] = useState<RecyledUrlDataType[]>([]);
    const [isLoading, setLoaded] = useState(true);

    useEffect(() => {
        fetchRecyledUrls().then((fetchedData) => {
            setLoaded(false);
            setRecyles(fetchedData);
        });
    }, []);

    const restoreRecyle = async (id: number) => {
        const restoreSuccess = await restoreRecyledUrl(id);
        if (restoreSuccess) {
            setRecyles((prevState) => prevState.filter((r) => r.id !== id));
        }
    };

    const handlePermanentDeleteRecyle = async (id: number) => {
        const deleteSuccess = await deleteRecyledUrl(id);
        if (deleteSuccess) {
            setRecyles((prevState) => prevState.filter((r) => r.id !== id));
        }
    };

    const listItems = recycles.map((recycle) => (
        <Paper elevation={1} style={{ margin: "0.25rem" }} key={recycle.id}>
            <ListItem button>
                <IconButton
                    onClick={() => restoreRecyle(recycle.id)}
                    edge="start"
                    aria-label="restore"
                >
                    <MdSettingsBackupRestore />
                </IconButton>
                <ListItemText>
                    <Typography variant="subtitle1">
                        {recycle.location.length > 25
                            ? recycle.location.slice(0, 25) + "..."
                            : recycle.location}
                    </Typography>
                    <Typography variant="caption">{recycle.slug}</Typography>
                </ListItemText>
                <ListItemSecondaryAction>
                    <IconButton
                        onClick={() => handlePermanentDeleteRecyle(recycle.id)}
                        edge="end"
                        aria-label="delete"
                    >
                        <CgTrashEmpty />
                    </IconButton>
                </ListItemSecondaryAction>
            </ListItem>
        </Paper>
    ));

    return (
        <Box>
            {isLoading ? (
                <Box margin="1rem 0">
                    <LinearProgress color="secondary" />
                </Box>
            ) : (
                <List component="nav" aria-label="all murl urls">
                    {listItems}
                </List>
            )}
        </Box>
    );
}
