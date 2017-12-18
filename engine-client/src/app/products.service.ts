import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from '../environments/environment';

const httpOptions = {
  headers: new HttpHeaders({'Content-Type' : 'application/json'})
};

@Injectable()
export class ProductsService {

  constructor(private http: HttpClient) { 
    this.http.get(environment.base_url + "/products")
      .subscribe(
      data => {
       console.log(data)
    },
     error=>{
       
    });
  }

}
