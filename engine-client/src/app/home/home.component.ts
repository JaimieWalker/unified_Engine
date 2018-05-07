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
  recent : any
  

  constructor(private market_data: MarketDataService, private route: ActivatedRoute) {
    this.recent = this.route.snapshot.data.recent.body
    this.market_data.productservice.recent_products = this.recent
    let data = this.route.snapshot.data.products
    for (let prod of data) {
      let product = new Product(prod.display_name);
      product.product_name = prod.product_name
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
      product.price = null;
      product.g_price = null;
      product.k_price = null;
      product.c_price = null;
      product.time = null;
      product.g_time = null;
      product.c_time = null;
      product.k_time = null;
      this.market_data.productservice.products[prod.base_currency + "-" + prod.quote_currency] = product
    }
     
    this.products = this.market_data.productservice.products
    this.keys = Object.keys(this.products)
    this.values = Object.values(this.products)
  }
  


  ngOnInit() {
    
    // if it is just time or price, then this is for gdax
    let prodService = this.market_data.productservice
    for(let prod in this.recent){
      let val = this.recent[prod]
      let c_time: any = new Date(val["coinbase_time"])
      let time: any = new Date(val["gdax_time"])
      let g_time: any = new Date(val["gemini_time"])
      let k_time: any = new Date(val["kraken_time"])
      c_time.getFullYear() === 1969 ? c_time = null : c_time = c_time.toLocaleTimeString();
      time.getFullYear() === 1969 ? time = null : time = time.toLocaleTimeString();
      g_time.getFullYear() === 1969 ? g_time = null : g_time = g_time.toLocaleTimeString();
      k_time.getFullYear() === 1969 ? k_time = null : k_time = k_time.toLocaleTimeString();
      prodService.set_coinbase_price(prod,val["coinbase_price"] || null)
      prodService.set_coinbase_time(prod,c_time)
      prodService.set_gdax_price(prod,val["gdax_price"] || null)
      prodService.set_gdax_time(prod, time)
      prodService.set_gemini_price(prod,val["gemini_price"] || null)
      prodService.set_gemini_time(prod, g_time)
      prodService.set_kraken_price(prod,val["kraken_price"] || null)
      prodService.set_kraken_time(prod,k_time)
    }
    console.log(this.products)
  }


  spread(value){
    let arr = [value.price, value.k_price, value.c_price, value.g_price]
     let spread: any = this.max(arr) - this.min(arr)
     if (spread == "-Infinity") {
       return 0
     }
    return spread
  }

  max(arr: number[]){
    let max = Math.max.apply(null, arr.filter(Boolean))
    if (max == "-Infinity") {
      return max = 0
    }
    return max
  }

  min(arr: number[]){

    let min = Math.min.apply(null, arr.filter(Boolean))
    if (min == "Infinity") {
      return min = 0
    }
    return min
  }
  
  // Style changes


  gdaxPrice(element){
    let price = element.price + 0
    let arr = [element.price, element.k_price, element.c_price, element.g_price]
    if((price == this.min(arr) || price == this.max(arr)) && price != 0){
      return "blue"
    }else if(price){
      return;
    }
    return "black" 
  }

  // gdaxTime(element){
  //   return element.time ? "lightgray" : "black" 
  // }

  geminiPrice(element){
    let price = element.g_price + 0

    let arr = [element.price, element.k_price, element.c_price, element.g_price]
    if((price == this.min(arr) || price == this.max(arr)) && price != 0){
      
      return "blue"
    } else if (price) {
      return;
    }
    
    return "black" 
  }
  // geminiTime(element){
  //   return element.g_time ? "lightgray" : "black" 
  // }
  krakenPrice(element){
    let price = element.k_price + 0
    let arr = [element.price, element.k_price, element.c_price, element.g_price]
    if ((price == this.min(arr) || price == this.max(arr)) && price != 0) {
      return "blue"
    } else if (price) {
      return;
    }
    return "black"
  }
  // krakenTime(element){
  //   return element.k_time ? "lightgray" : "black" 
  // }
  coinbasePrice(element){
    let price = element.c_price + 0
    let arr = [element.price, element.k_price, element.c_price, element.g_price]
    if ((price == this.min(arr) || price == this.max(arr)) && price != 0) {
      return "blue"
    } else if (price) {
      return;
    }
    return "black" 
  }
  // coinbaseTime(element){
  //   return element.c_time ? "lightgray" : "black" 
  // }
  


}
