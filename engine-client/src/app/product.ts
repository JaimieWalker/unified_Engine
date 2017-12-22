export class Product {
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
    // This number will change based on the quote currency
    price: number;
    constructor(id:string){
        this.id = id;
    }

    
}
