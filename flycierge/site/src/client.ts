export class Client {
    url: string;

    constructor(url: string) {
        this.url = url;
    }

    validateResponseStatus = (response: Response) => {
        if (response.status >= 200 && response.status < 300) {
            return response;
        } else {
            throw new Error(response.statusText);
        }
    }

    fetchData = async <T> (endpoint: string, method?: string, params?: Record<string, any>): Promise<T> => {
        const endpointUrl = this.url + `${endpoint}`;
        return fetch(endpointUrl,  {
            method: method || 'GET',
            headers: {
                'Content-type': "application/json; charset=utf-8",
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify(params)
        })
        .then(this.validateResponseStatus)
        .then(res => res.json());
    }
}