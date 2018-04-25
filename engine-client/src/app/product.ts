import { CommonModule } from '@angular/common';

export class Product {
    id: string;
    product_name: string
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
    price: any;
    k_price: any;
    g_price: any;
    c_price: any;
    time: any;
    c_time: any;
    k_time: any;
    g_time: any;
    constructor(id:string){
        this.id = id;
    }

    
}
