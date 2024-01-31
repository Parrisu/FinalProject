import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'notIn',
  standalone: true,
})
export class NotInPipe implements PipeTransform {
  transform<T>(firstArr: T[], secondArr: T[]): T[] {
    return firstArr.filter((item: T) => !secondArr.includes(item));
  }
}
