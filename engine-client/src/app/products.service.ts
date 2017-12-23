import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from '../environments/environment';
import { Product } from './product';

const httpOptions = {
  headers: new HttpHeaders({'Content-Type' : 'application/json'})
};

@Injectable()
export class ProductsService {
  products = {};
  // When the user connects, create a dictionary/hash of all the current products in the database
  get_products(){

  }

  constructor(private http: HttpClient) { 
    this.http.get(environment.base_url + "/products")
      .subscribe(
      (data: Product[]) => {
        for (let prod of data) {
          let product = new Product(prod.display_name);
          product.base_currency = prod.base_currency;
          product.base_max_size = prod.base_max_size;
          product.base_min_size = prod.base_min_size;
          product.id = prod.id;
          product.margin_enabled = prod.margin_enabled;
          product.quote_currency = prod.quote_currency;
          product.quote_increment = prod.quote_increment;
          product.status = prod.status;
          product.status_message = prod.status_message
          // Price needs to come from some sort of cache from the database
          product.price = 0;
          this.products[prod.base_currency + "-" + prod.quote_currency] = product
        }
        console.log(this.products);
    },
     error=>{
       
    });
  }

}
