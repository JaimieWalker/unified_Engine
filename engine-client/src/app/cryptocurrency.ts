export class Cryptocurrency {
    id: string;
    base_currency: string;
    quote_currency: string;
    base_min_size: number;
    base_max_size: number;
    quote_increment: number;
    display_name: string;
    status: string;
    margin_enabled: boolean;
    status_message: string;

    constructor(id:string){
        this.id = id;
    }

    
}
