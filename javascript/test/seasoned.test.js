import * as assert from 'assert';

import { hasTwoInARow, sumOfPrefixes, scramble } from '../src/seasoned.js';

describe('hasTwoInARow', () => {
    it('empty arrays', () => {
        assert.strictEqual(hasTwoInARow([]), false);
    });

    it('one element arrays', () => {
        assert.strictEqual(hasTwoInARow([1]), false);
    });

    it('beginnig of array', () => {
        assert.strictEqual(hasTwoInARow([1, 1, 2, 3]), true);
    });

    it('middle of array', () => {
        assert.strictEqual(hasTwoInARow([1, 2, 2, 3]), true);
    });

    it('end of array', () => {
        assert.strictEqual(hasTwoInARow([1, 2, 3, 3]), true);
    });

    it('nowhere', () => {
        assert.strictEqual(hasTwoInARow([1, 2, 3, 4]), false);
    });
});

describe('sumOfPrefixes', () => {
    it('empty arrays', () => {
        assert.deepStrictEqual(sumOfPrefixes([]), []);
    });

    it('single element', () => {
        assert.deepStrictEqual(sumOfPrefixes([7]), [7]);
    });

    it('multiple elements', () => {
        assert.deepStrictEqual(sumOfPrefixes([1, 2, 3, 4]), [1, 3, 6, 10]);
    });
});

describe('scramble', () => {
    it('empty array', () => {
        assert.deepStrictEqual(scramble([]), []);
    });

    it('multiple elements', () => {
        assert.deepStrictEqual(scramble([1, 1, 1, 3, 4, 2, 1, 1, 9, 2]), [1, 1, 1, 1, 1, 4, 1, 1, 1, 9]);
    });
});
