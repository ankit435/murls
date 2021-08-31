import axios from "axios";

import { AddUrlDataType } from "../types";

export async function postUrl(data: AddUrlDataType) {
    return axios({
        method: "POST",
        url: "http://52.226.16.59/_/urls",
        headers: {
            Authorization: "blue",
        },
        data: data,
    })
        .then((response) => response.data)
        .catch((_e) => ({
            "detail": "Please recheck your network connection!",
        }));
}
