import * as assert from 'assert';

import { isAtom, isEmpty, car, cdr, cons, isListOfAtoms, isMember, removeMember, firsts, insertRight, insertLeft, subst, subst2, multiRemoveMember, multiInsertRight, multiInsertLeft, multiSubst } from '../src/little.js';

describe('isAtom', () => {
    it('handles strings', () => {
        assert.strictEqual(isAtom('turkey'), true);
    });

    it('handles numbers', () => {
        assert.strictEqual(isAtom(1492), true);
    });

    it('handles empty arrays', () => {
        assert.strictEqual(isAtom([]), false);
    });

    it('handles arrays', () => {
        assert.strictEqual(isAtom([1, 2, 3]), false);
    });
});

describe('isEmpty', () => {
    it('handles atoms', () => {
        assert.strictEqual(isEmpty(12), false);
    });

    it('handles empty arrays', () => {
        assert.strictEqual(isEmpty([]), true);
    });

    it('handles arrays', () => {
        assert.strictEqual(isEmpty([1, 2]), false);
    });
});

describe('car', () => {
    it('returns first item in an array', () => {
        assert.strictEqual(car([0, 1]), 0);
    });

    it('handles nested arrays', () => {
        assert.deepStrictEqual(car([[0], 1]), [0]);
    });
});

describe('cdr', () => {
    it('returns the rest of an array', () => {
        assert.deepStrictEqual(cdr([0, 1, 2]), [1, 2]);
    });

    it('handles nested arrays', () => {
        assert.deepStrictEqual(cdr([0, [1], 2]), [[1], 2]);
    });
});

describe('cons', () => {
    it('adds an atom to the front of a list', () => {
        assert.deepStrictEqual(cons(0, [1, 2, 3]), [0, 1, 2, 3]);
    });
});

describe('isListOfAtoms', () => {
    it('handles empty array', () => {
        assert.strictEqual(isListOfAtoms([]), true);
    });

    it('handles simple arrays', () => {
        assert.strictEqual(isListOfAtoms(['Jack', 'Sprat', 'could', 'eat', 'no', 'fat']), true);
    });

    it('handles nested arrays', () => {
        assert.strictEqual(isListOfAtoms([['Jack'], 'Sprat', 'could', 'eat', 'no', 'fat']), false);
    });
});

describe('isMember', () => {
    it('handles members', () => {
        assert.strictEqual(isMember('tea', ['coffee', 'tea', 'or', 'milk']), true);
    });

    it('handles non members', () => {
        assert.strictEqual(isMember('poached', ['fried', 'eggs', 'and', 'scrambled', 'eggs']), false);
    });
});

describe('removeMember', () => {
    it('removes the first matching member', () => {
        assert.deepStrictEqual(removeMember('and', ['bacon', 'lettuce', 'and', 'tomato']), ['bacon', 'lettuce', 'tomato']);
    });
});

describe('firsts', () => {
    it('returns the first element from each array in an array of arrays', () => {
        assert.deepStrictEqual(firsts([['a', 'b'], ['c', 'd'], ['e', 'f']]), ['a', 'c', 'e']);
    });
});

describe('insertRight', () => {
    it('inserts the new atom to the right of the old atom in the list', () => {
        assert.deepStrictEqual(insertRight('topping', 'fudge', ['ice', 'cream', 'with', 'fudge', 'for', 'dessert']), ['ice', 'cream', 'with', 'fudge', 'topping', 'for', 'dessert']);
    });
});

describe('insertRight', () => {
    it('inserts the new atom to the left of the old atom in the list', () => {
        assert.deepStrictEqual(insertLeft('chocolate', 'fudge', ['ice', 'cream', 'with', 'fudge', 'for', 'dessert']), ['ice', 'cream', 'with', 'chocolate', 'fudge', 'for', 'dessert']);
    });
});

describe('subst', () => {
    it('substitutes the new atom for the old atom in the list', () => {
        assert.deepStrictEqual(subst('topping', 'fudge', ['ice', 'cream', 'with', 'fudge', 'for', 'dessert']), ['ice', 'cream', 'with', 'topping', 'for', 'dessert']);
    });
});

describe('subst2', () => {
    it('substitutes the new atom for either of the old atoms in the list', () => {
        assert.deepStrictEqual(subst2('vanilla', 'chocolate', 'banana', ['banana', 'ice', 'cream', 'with', 'chocolate', 'topping']), ['vanilla', 'ice', 'cream', 'with', 'chocolate', 'topping']);
    });
});

describe('multiRemoveMember', () => {
    it('removes all matching members', () => {
        assert.deepStrictEqual(multiRemoveMember('cup', ['coffee', 'cup', 'tea', 'cup', 'and', 'hick', 'cup']), ['coffee', 'tea', 'and', 'hick']);
    });
});

describe('multiInsertRight', () => {
    it('inserts new atom to right of all matching old atoms in list', () => {
        assert.deepStrictEqual(multiInsertRight('fudge', 'chocolate', ['chocolate', 'ice', 'cream', 'with', 'chocolate', 'topping']), ['chocolate', 'fudge', 'ice', 'cream', 'with', 'chocolate', 'fudge', 'topping']);
    });
});

describe('multiInsertLeft', () => {
    it('inserts new atom to right of all matching old atoms in list', () => {
        assert.deepStrictEqual(multiInsertLeft('chocolate', 'fudge', ['fudge', 'ice', 'cream', 'with', 'fudge', 'for', 'dessert']), ['chocolate', 'fudge', 'ice', 'cream', 'with', 'chocolate', 'fudge', 'for', 'dessert']);
    });
});

describe('multiSubst', () => {
    it('replaces all matching old atoms with the new atom in the list', () => {
        assert.deepStrictEqual(multiSubst('vanilla', 'chocolate', ['chocolate', 'ice', 'cream', 'with', 'chocolate', 'topping']), ['vanilla', 'ice', 'cream', 'with', 'vanilla', 'topping']);
    });
});
