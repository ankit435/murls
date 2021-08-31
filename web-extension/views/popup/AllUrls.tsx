import { useEffect, useState } from "preact/hooks";
import {
    Box,
    List,
    ListItem,
    ListItemText,
    CircularProgress,
} from "@material-ui/core";

import { fetchAllUrls } from "../../src/utils/fetchData";
import { urlDataType } from "../../src/types/index";

export default function AllUrlsList() {
    const [urlDatas, setUrlDatas] = useState<urlDataType[]>([]);
    const [isLoading, setLoaded] = useState(true);

    useEffect(() => {
        fetchAllUrls().then((fetchedData) => {
            setLoaded(false);
            setUrlDatas(fetchedData);
        });
    }, []);

    const listItems = urlDatas.map((urlData) => (
        <ListItem button key={urlData.id}>
            <ListItemText
                primary={
                    urlData.location.length !== 0
                        ? urlData.location
                        : urlData.slug
                }
            />
        </ListItem>
    ));

    return (
        <Box>
            {isLoading ? (
                <CircularProgress color="secondary" />
            ) : (
                <List component="nav" aria-label="all murl urls">
                    {listItems}
                </List>
            )}
        </Box>
    );
}
