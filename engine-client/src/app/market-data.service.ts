import { Injectable } from '@angular/core';
import { Ng2Cable, Broadcaster } from 'ng2-cable'
import { environment } from '../environments/environment.prod';
import { ProductsService } from './products.service';

@Injectable()
export class MarketDataService {

  constructor(private ng2cable: Ng2Cable,
    private broadcaster: Broadcaster, public productservice: ProductsService) { 
    this.ng2cable.subscribe(environment.base_url + '/cable', 'ProductChannel');
    this.broadcaster.on<string>('ProductChannel').subscribe(
      message => {
        let match = JSON.parse(message);
        // This is a model, must turn product into an angular model
        productservice.set_price(match.product_name, match.price)
        
        console.log(productservice.get_products()["BTC-USD"].price)
      },
      error => {
        alert("error");
      }
    );

  }

}
