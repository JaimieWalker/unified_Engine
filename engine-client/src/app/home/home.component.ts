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
  item: Product;
  
  itemCount: number = 4;
  constructor(private _data: MarketDataService, private product_data: ProductsService ) {
    
   }

  ngOnInit() {
    
  }

}
