import * as assert from 'assert';

import { hasTwoInARow } from '../src/seasoned.js';

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

