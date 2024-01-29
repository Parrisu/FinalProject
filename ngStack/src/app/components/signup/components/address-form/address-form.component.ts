import { Component, ElementRef, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-address-form',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './address-form.component.html',
  styleUrl: './address-form.component.css',
})
export class AddressFormComponent {
  @ViewChild('streetError') streetError!: ElementRef<HTMLDivElement>;
  @ViewChild('zipCodeError') zipCodeError!: ElementRef<HTMLDivElement>;
  @ViewChild('cityError') cityError!: ElementRef<HTMLDivElement>;

  public street = '';
  public zipCode = '';
  public city = '';

  validateStreet(): void {}
  validateZipCode(): void {}
  validateCity(): void {}

  public validateAll(): boolean {
    return true; // TEMPORARY
  }
}
