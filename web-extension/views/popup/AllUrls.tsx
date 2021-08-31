import { useEffect, useState } from "preact/hooks";
import { IoRocket, IoRocketOutline } from "react-icons/io5";
import { CgTrashEmpty } from "react-icons/cg";
import {
    Box,
    IconButton,
    List,
    ListItem,
    ListItemSecondaryAction,
    ListItemText,
    LinearProgress,
    ListItemIcon,
    Typography,
} from "@material-ui/core";

import { fetchAllUrls, deleteUrl } from "../../src/utils/fetchData";
import { UrlDataType } from "../../src/types/index";

export default function AllUrlsList() {
    const [urlDatas, setUrlDatas] = useState<UrlDataType[]>([]);
    const [isLoading, setLoaded] = useState(true);

    useEffect(() => {
        fetchAllUrls().then((fetchedData) => {
            setLoaded(false);
            setUrlDatas(fetchedData);
        });
    }, []);

    const handleDeleteUrl = async (id: number) => {
        const deleteSuccess = await deleteUrl(id);
        if (deleteSuccess) {
            setUrlDatas((prevState) => prevState.filter((u) => u.id !== id));
        }
    };

    const listItems = urlDatas.map((urlData) => (
        <ListItem button key={urlData.id}>
            <ListItemIcon>
                {urlData.boosted ? (
                    <IoRocket color="red" />
                ) : (
                    <IoRocketOutline />
                )}
            </ListItemIcon>
            <ListItemText>
                <Typography variant="subtitle1">
                    {urlData.location.length > 25
                        ? urlData.location.slice(0, 25) + "..."
                        : urlData.location}
                </Typography>
                <Typography variant="caption">{urlData.slug}</Typography>
            </ListItemText>
            <ListItemSecondaryAction>
                <IconButton
                    onClick={() => handleDeleteUrl(urlData.id)}
                    edge="end"
                    aria-label="delete"
                >
                    <CgTrashEmpty />
                </IconButton>
            </ListItemSecondaryAction>
        </ListItem>
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
