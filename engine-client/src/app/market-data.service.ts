import { Injectable } from '@angular/core';
import { Ng2Cable, Broadcaster } from 'ng2-cable'

@Injectable()
export class MarketDataService {

  constructor(private ng2cable: Ng2Cable,
    private broadcaster: Broadcaster) { 
    this.ng2cable.subscribe('https://localhost:3000/cable', 'ProductChannel');
    this.broadcaster.on<string>('ProductChannel').subscribe(
      message => {
        console.log(message);
      }
    );

  }

}
