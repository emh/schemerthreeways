import { car, cdr, cons, isEmpty, pick } from './little.js';

export const hasTwoInARowB = (preceding, lat) =>
    isEmpty(lat) ? false
    : preceding === car(lat) || hasTwoInARowB(car(lat), cdr(lat));

export const hasTwoInARow = (lat) => hasTwoInARowB(car(lat), cdr(lat));

export const sumOfPrefixesB = (sonssf, tup) =>
    isEmpty(tup) ? []
    : cons(sonssf + car(tup), sumOfPrefixesB(sonssf + car(tup), cdr(tup)));

export const sumOfPrefixes = (tup) => sumOfPrefixesB(0, tup);

export const scrambleB = (tup, revPre) =>
    isEmpty(tup) ? []
    : cons(pick(car(tup), cons(car(tup), revPre)), scrambleB(cdr(tup), cons(car(tup), revPre)));

export const scramble = (tup) => scrambleB(tup, []);

