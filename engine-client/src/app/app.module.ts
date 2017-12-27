import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { MarketDataService } from './market-data.service';
import { Ng2CableModule } from 'ng2-cable';
import { ProductsService } from './products.service';
import { HttpClientModule } from '@angular/common/http';
import { ProdResolver } from './product.resolver';


@NgModule({
  declarations: [
    AppComponent,
    HomeComponent
  ],
  imports: [Ng2CableModule,
    BrowserModule,
    AppRoutingModule,
    HttpClientModule
  ],
  providers: [MarketDataService, ProductsService, ProdResolver],
  bootstrap: [AppComponent]
})
export class AppModule { }
