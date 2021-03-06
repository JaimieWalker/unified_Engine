import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from '../environments/environment';
import { Product } from './product';
import { Observable } from 'rxjs/Observable';
import { CommonModule } from '@angular/common';

const httpOptions = {
  headers: new HttpHeaders({'Content-Type' : 'application/json'})
};

@Injectable()
export class ProductsService {
  recent_products: any;
  products :any;
  endpoint = environment.base_url + "/products"
  krakenStatus = "green"
  geminiStatus = "green"
  gdaxStatus = "green"
  coinbaseStatus = "green"
  
  constructor(private http: HttpClient) {
    this.products = {}
  }
  
  initialize_products():Observable<any>{
    let product_url = environment.base_url + "/recent"
    return this.http.get<any>(product_url, { observe: 'response' });
  }

  set_coinbase_price(product: string, price: number) {
    this.products[product].c_price = price;
  }

  set_coinbase_time(product: string, time: any){
    this.products[product].c_time = time
  }
   
  set_gemini_price(product: string,price: number){
    this.products[product].g_price = price;
  }
  set_gemini_time(product: string, time: any) {
    this.products[product].g_time = time
  }
  set_kraken_price(product: string,price: number){
    this.products[product].k_price = price;
  }
  set_kraken_time(product: string, time: any) {
    this.products[product].k_time = time
  }
  set_gdax_price(product: string,price: number){
    this.products[product].price = price;
  }
  set_gdax_time(product: string, time: any){
    this.products[product].time = time
   }

  get_products():any{
    return this.products
  }


  // When the user connects, create a dictionary/hash of all the current products in the database
  create_products():Observable<any>{
    return this.http.get(this.endpoint)
  }
// .subscribe(
//             (data: Product[]) => {
  // for (let prod of data) {
  //   let product = new Product(prod.display_name);
  //   product.base_currency = prod.base_currency;
  //   product.base_max_size = prod.base_max_size;
  //   product.base_min_size = prod.base_min_size;
  //   product.id = prod.id;
  //   product.margin_enabled = prod.margin_enabled;
  //   product.quote_currency = prod.quote_currency;
  //   product.quote_increment = prod.quote_increment;
  //   product.status = prod.status;
  //   product.status_message = prod.status_message
  //   // Price needs to come from some sort of cache from the database
  //   product.price = 0;
  //   this.productService.products[prod.base_currency + "-" + prod.quote_currency] = product
  // }
//   console.log(this.productService.get_products())
// },
//   error => {
//     console.log("Error")
//   });

  

}
