import { Component, OnInit } from '@angular/core';
import { MarketDataService } from '../market-data.service';
import { ProductsService} from '../products.service';
import { Product } from '../Product';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  itemCount: number = 4;
  products: any;
  constructor(private market_data: MarketDataService) {
    this.products = this.market_data.productservice.products
  }

  
  ngOnInit() {
  }

}
