import { Pipe, PipeTransform } from '@angular/core';
import { City } from '../models/city';

@Pipe({
  name: 'formatCity',
  standalone: true,
})
export class FormatCityPipe implements PipeTransform {
  transform(city: City): string {
    return `${city.id}, ${city.state}`;
  }
}
