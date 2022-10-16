import { car, cdr, cons, isEmpty } from './little.js';

export const hasTwoInARowB = (preceding, lat) =>
    isEmpty(lat) ? false
    : preceding === car(lat) || hasTwoInARowB(car(lat), cdr(lat));

export const hasTwoInARow = (lat) =>
    isEmpty(lat) ? false
    : hasTwoInARowB(car(lat), cdr(lat));


