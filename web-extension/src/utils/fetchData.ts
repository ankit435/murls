import axios from "axios";

import { UrlDataType, AddUrlDataType, RecyledUrlDataType } from "../types";
import { getBaseUrl } from "./getConfig";

const fetcher = (authToken: string) =>
    axios.create({
        baseURL: getBaseUrl(),
        timeout: 5000,
        headers: { Authorization: authToken },
    });

export async function fetchAllUrls(
    authToken: string
): Promise<Array<UrlDataType>> {
    return fetcher(authToken)
        .get("/_/urls")
        .then((response) => response.data)
        .catch((e) => {
            console.log("the error while fetching all urls ", e);
            return [];
        });
}

export async function postUrl(authToken: string, data: AddUrlDataType) {
    return fetcher(authToken)
        .post("/_/urls", { ...data, name: data.slug })
        .then((response) => response.data)
        .catch((_e) => ({
            detail: "Please recheck your network connection!",
        }));
}

export async function deleteUrl(authToken: string, id: number) {
    return fetcher(authToken)
        .delete("/_/urls/" + id)
        .then((response) => true)
        .catch((_e) => false);
}

export async function fetchRecyledUrls(
    authToken: string
): Promise<Array<RecyledUrlDataType>> {
    return fetcher(authToken)
        .get("/_/recycled-urls")
        .then((response) => response.data)
        .catch((_e) => []);
}

export async function deleteRecyledUrl(authToken: string, id: number) {
    return fetcher(authToken)
        .delete("/_/recycled-urls/" + id)
        .then((response) => true)
        .catch((_e) => false);
}

export async function restoreRecyledUrl(authToken: string, id: number) {
    return fetcher(authToken)
        .get("/_/recycled-urls/" + id)
        .then((response) => true)
        .catch((_e) => false);
}
