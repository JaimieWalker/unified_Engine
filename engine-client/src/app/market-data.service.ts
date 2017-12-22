import { Injectable } from '@angular/core';
import { Ng2Cable, Broadcaster } from 'ng2-cable'
import { environment } from '../environments/environment.prod';

@Injectable()
export class MarketDataService {

  constructor(private ng2cable: Ng2Cable,
    private broadcaster: Broadcaster) { 
    this.ng2cable.subscribe(environment.base_url + '/cable', 'ProductChannel');
    this.broadcaster.on<string>('ProductChannel').subscribe(
      message => {
        console.log(message);
      },
      error => {
        alert("error");
      }
    );

  }

}
