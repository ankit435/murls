export type UrlDataType = {
    id: number;
    shortened: string;
    name: string;
    location: string;
    boosted: boolean;
    clicks: number;
    slug: string;
    expiry_date: string;
    created_at: string;
    updated_at: string;
};

export type AddUrlDataType = Pick<
    UrlDataType,
    "slug" | "location" | "boosted" | "expiry_date"
>;

export type RecyledUrlDataType = Omit<
    UrlDataType,
    "boosted" | "clicks" | "expiry_date" | "created_at" | "updated_at"
>;
