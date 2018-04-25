import { Injectable } from '@angular/core';

import { Resolve } from '@angular/router';
import { Product } from './product';
import { CommonModule } from '@angular/common';

import { Observable } from 'rxjs/Observable';
import { ProductsService } from './products.service'
import 'rxjs/add/observable/of';
import 'rxjs/add/operator/delay';

@Injectable()
export class ProdResolver implements Resolve<Observable<any>> {
    constructor(private productService: ProductsService ) { }

    resolve() {
        return this.productService.create_products()
    }
}