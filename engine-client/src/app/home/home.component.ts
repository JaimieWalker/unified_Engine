import { Component, OnInit } from '@angular/core';
import { MarketDataService } from '../market-data.service';
import { ProductsService} from '../products.service';
import { Product } from '../product';
import { ActivatedRoute } from '@angular/router';
import { NgForOf } from '@angular/common';
import { CommonModule } from '@angular/common';


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  products: any;
  keys: any;
  values: any;
  
  
  constructor(private market_data: MarketDataService, private route: ActivatedRoute) {
   
    let data = this.route.snapshot.data.products
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
      this.market_data.productservice.products[prod.base_currency + "-" + prod.quote_currency] = product
    }
    this.products = this.market_data.productservice.products
    this.keys = Object.keys(this.products)
    this.values = Object.values(this.products)
  }

  
  ngOnInit() {
    console.log(this.products)
  }

}
