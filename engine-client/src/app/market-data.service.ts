import { Injectable } from '@angular/core';
import { Ng2Cable, Broadcaster } from 'ng2-cable'
import { environment } from '../environments/environment.prod';
import { ProductsService } from './products.service';
import { CommonModule } from '@angular/common';
import { error } from 'util';

@Injectable()
export class MarketDataService {
  constructor(private ng2cable: Ng2Cable,
    private broadcaster: Broadcaster, public productservice: ProductsService) {

    this.ng2cable.subscribe(environment.base_url + '/cable', 'ProductChannel');
    this.ng2cable.subscribe(environment.base_url + '/g_cable', 'GeminiMatchesChannel')
    this.ng2cable.subscribe(environment.base_url + '/k_cable', "KrakenMatchesChannel")
    this.ng2cable.subscribe(environment.base_url + '/c_cable', "CoinbaseChannel")
    
    // gdaxbroadcaster
    this.broadcaster.on<string>('ProductChannel').subscribe(
      message => {
        let match = JSON.parse(message);
        // This is a model, must turn product into an angular model
        productservice.set_price(match.product_name, match.price)
        console.log(productservice.get_products()["BTC-USD"].price)
      },
      error => {
      }
    );

    this.broadcaster.on<string>('KrakenMatchesChannel').subscribe(
      message => {
        let match = JSON.parse(message);
        productservice.set_kraken_price(match.product_name, match.price)
      },
      error => {}
    );
    this.broadcaster.on<string>('CoinbaseChannel').subscribe(
      message => {
        let match = JSON.parse(message);
        productservice.set_coinbase_price(match.product_name, match.price)
      },
      error => {}
    );
    this.broadcaster.on<string>('GeminiMatchesChannel').subscribe(
      message => {
        let match = JSON.parse(message);
        productservice.set_gemini_price(match.product_name, match.price)
      },
      error => {}
    );

  }
  
}
