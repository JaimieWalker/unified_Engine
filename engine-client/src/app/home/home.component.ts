import { Component, OnInit } from '@angular/core';
import { MarketDataService } from '../market-data.service';


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  itemCount: number = 4;
  constructor(private _data: MarketDataService) { }

  ngOnInit() {
    
  }

}
