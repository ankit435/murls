import axios from "axios";

import { UrlDataType, AddUrlDataType, RecyledUrlDataType } from "../types";

const fetcher = axios.create({
    baseURL: "http://localhost:9000",
    timeout: 5000,
    headers: { Authorization: "blue" },
});

export async function fetchAllUrls(): Promise<Array<UrlDataType>> {
    return fetcher
        .get("/_/urls")
        .then((response) => response.data)
        .catch((e) => {
            console.log("the error while fetching all urls ", e);
            return [];
        });
}

export async function postUrl(data: AddUrlDataType) {
    return fetcher
        .post("/_/urls", data)
        .then((response) => response.data)
        .catch((_e) => ({
            detail: "Please recheck your network connection!",
        }));
}

export async function deleteUrl(id: number) {
    return fetcher
        .delete("/_/urls/" + id)
        .then((response) => true)
        .catch((_e) => false);
}

export async function fetchRecyledUrls(): Promise<Array<RecyledUrlDataType>> {
    return fetcher
        .get("/_/recycled-urls")
        .then((response) => response.data)
        .catch((_e) => []);
}

export async function deleteRecyledUrl(id: number) {
    return fetcher
        .delete("/_/recycled-urls/" + id)
        .then((response) => true)
        .catch((_e) => false);
}

export async function restoreRecyledUrl(id: number) {
    return fetcher
        .get("/_/recycled-urls/" + id)
        .then((response) => true)
        .catch((_e) => false);
}
