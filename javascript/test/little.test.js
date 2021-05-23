import * as assert from 'assert';

import { isAtom, isEmpty, car, cdr, cons, isListOfAtoms, isMember, removeMember, firsts, insertRight, insertLeft, subst, subst2, multiRemoveMember, multiInsertRight, multiInsertLeft, multiSubst, add1, sub1, isZero, plus, minus, addTup, mult, tupPlus, isGreater, isLess, isEqual, expt, div, length, pick, removePick, noNums, allNums, occur, removeMemberAll, insertRightAll, occurAll, substAll, insertLeftAll, memberAll, leftMost, isDeepEqual, removeMember2, isNumbered, value, isSet, makeSet, makeSet2, isSubset, isEqualSets, doesIntersect, intersect } from '../src/little.js';

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

describe('add1', () => {
    it('adds 1 to n', () => {
        assert.strictEqual(add1(67), 68);
    })
});

describe('sub1', () => {
    it('subtracts 1 from n', () => {
        assert.strictEqual(sub1(67), 66);
    })
});

describe('isZero', () => {
    it('tests if n is zero', () => {
        assert.strictEqual(isZero(0), true);
        assert.strictEqual(isZero(67), false);
    });
});

describe('plus', () => {
    it('adds two numbers', () => {
        assert.strictEqual(plus(46, 12), 58);
    });
});

describe('minus', () => {
    it('subtracts two numbers', () => {
        assert.strictEqual(minus(17, 9), 8);
    });
});

describe('addTup', () => {
    it('sums the values in a tup', () => {
        assert.strictEqual(addTup([3, 5, 2, 8]), 18);
    });
});

describe('mult', () => {
    it('multiplies two numbers', () => {
        assert.strictEqual(mult(13, 4), 52);
    });
});

describe('tupPlus', () => {
    it('sums two tups', () => {
        assert.deepStrictEqual(tupPlus([3, 6, 9, 11, 4], [8, 5, 2, 0, 7]), [11, 11, 11, 11, 11]);
    });

    it('sums two tups of different lengths', () => {
        assert.deepStrictEqual(tupPlus([3, 7, 8, 1], [4, 6]), [7, 13, 8, 1]);
    });
});

describe('isGreater', () => {
    it('tests if one number is bigger than another', () => {
        assert.deepStrictEqual(isGreater(12, 133), false);
        assert.deepStrictEqual(isGreater(120, 11), true);
        assert.deepStrictEqual(isGreater(3, 3), false);
    });
});

describe('isLess', () => {
    it('tests if one number is smaller than another', () => {
        assert.deepStrictEqual(isLess(4, 6), true);
        assert.deepStrictEqual(isLess(8, 3), false);
        assert.deepStrictEqual(isLess(6, 6), false);
    });
});

describe('isEqual', () => {
    it('tests if one number is the same as another', () => {
        assert.deepStrictEqual(isEqual(0, 0), true);
        assert.deepStrictEqual(isEqual(1, 83), false);
        assert.deepStrictEqual(isEqual(23, 2), false);
        assert.deepStrictEqual(isEqual(42, 42), true);
    });
});

describe('expt', () => {
    it('raises one number to the power of another', () => {
        assert.deepStrictEqual(expt(1, 1), 1);
        assert.deepStrictEqual(expt(2, 3), 8);
        assert.deepStrictEqual(expt(5, 3), 125);
    });
});

describe('div', () => {
    it('divides one number by another', () => {
        assert.deepStrictEqual(div(15, 4), 3);
    });
});

describe('length', () => {
    it('returns the number of atoms in a list', () => {
        assert.strictEqual(length(['hotdogs', 'with', 'mustard', 'sauerkraut', 'and', 'pickles']), 6);
        assert.strictEqual(length(['ham', 'and', 'cheese', 'on', 'rye']), 5);
    });
});

describe('pick', () => {
     it('picks the nth atom from the list', () => {
        assert.strictEqual(pick(4, ['lasagna', 'spaghetti', 'ravioli', 'macaroni', 'meatballs']), 'macaroni');
     });
});

describe('removePick', () => {
    it('removes the nth atom from the list', () => {
        assert.deepStrictEqual(removePick(3, ['hotdogs', 'with', 'hot', 'mustard']), ['hotdogs', 'with', 'mustard']);
    });
});

describe('noNums', () => {
    it('removes numbers from a list', () => {
        assert.deepStrictEqual(noNums([5, 'pears', 6, 'prunes', 9, 'dates']), ['pears', 'prunes', 'dates']);
    });
});

describe('allNums', () => {
    it('removes non numbers from a list', () => {
        assert.deepStrictEqual(allNums([5, 'pears', 6, 'prunes', 9, 'dates']), [5, 6, 9]);
    });
});

describe('occur', () => {
    it('counts the occurences of an atom in a list', () => {
        assert.strictEqual(occur('macaroni', ['lasagna', 'spaghetti', 'ravioli', 'macaroni', 'meatballs', 'macaroni']), 2);
        assert.strictEqual(occur('fettuccine', ['lasagna', 'spaghetti', 'ravioli', 'macaroni', 'meatballs', 'macaroni']), 0);
    });
});

describe('removeMemberAll', () => {
    it('removes all occurrences of an atom from a nested list', () => {
        assert.deepStrictEqual(removeMemberAll('cup', [['coffee'], 'cup', [['tea'], 'cup'], ['and', ['hick']], 'cup']), [['coffee'], [['tea']], ['and', ['hick']]]);
        assert.deepStrictEqual(removeMemberAll('sauce', [[['tomato', 'sauce']], [['bean'], 'sauce'], ['and', [['flying']], 'sauce']]), [[['tomato']], [['bean']], ['and', [['flying']]]]);
    });
});

describe('insertRightAll', () => {
    it('inserts the new atom to the right of the matching old atom in a nested list', () => {
        assert.deepStrictEqual(insertRightAll(2, 1, [1, 3, 4]), [1, 2, 3, 4]);
        assert.deepStrictEqual(insertRightAll(
            'roast',
            'chuck',
            [
                ['how', 'much', ['wood']],
                'could',
                [['a', ['wood'], 'chuck']],
                [[['chuck']]],
                ['if', ['a'], [['wood', 'chuck']]],
                'could', 'chuck', 'wood'
            ]), [
                ['how', 'much', ['wood']],
                'could',
                [['a', ['wood'], 'chuck', 'roast']],
                [[['chuck', 'roast']]],
                ['if', ['a'], [['wood', 'chuck', 'roast']]],
                'could', 'chuck', 'roast', 'wood'
            ]);
    });
});

describe('occurAll', () => {
    it('counts all occurrences of an atom in a nested list', () => {
        assert.strictEqual(occurAll('banana',               [['banana'], ['split', [[[['banana', 'ice']]], ['cream', ['banana']], 'sherbet']], ['banana'], ['bread'], ['banana', 'brandy']]), 5);
    });
});

describe('substAll', () => {
    it('replaces all occurrences of an atom in a nested list with a new atom', () => {
        assert.deepStrictEqual(substAll('orange', 'banana', [['banana'], ['split', [[[['banana', 'ice']]], ['cream', ['banana']], 'sherbet']], ['banana'], ['bread'], ['banana', 'brandy']]), [['orange'], ['split', [[[['orange', 'ice']]], ['cream', ['orange']], 'sherbet']], ['orange'], ['bread'], ['orange', 'brandy']]);
    });
});

describe('insertLeftAll', () => {
    it('inserts the new atom to the left of the matching old atom in a nested list', () => {
        assert.deepStrictEqual(insertLeftAll(1, 2, [2, 3, 4]), [1, 2, 3, 4]);
        assert.deepStrictEqual(insertLeftAll(
            'pecker',
            'chuck',
            [
                ['how', 'much', ['wood']],
                'could',
                [['a', ['wood'], 'chuck']],
                [[['chuck']]],
                ['if', ['a'], [['wood', 'chuck']]],
                'could', 'chuck', 'wood'
            ]), [
                ['how', 'much', ['wood']],
                'could',
                [['a', ['wood'], 'pecker', 'chuck']],
                [[['pecker', 'chuck']]],
                ['if', ['a'], [['wood', 'pecker', 'chuck']]],
                'could', 'pecker', 'chuck', 'wood'
            ]);
    });
});

describe('memberAll', () => {
    it('tests if an atom occurs anywhere in a nested list', () => {
        assert.strictEqual(memberAll('chips', [['potato'], ['chips', [['with'], 'fish'], ['chips']]]), true);
    });
});

describe('leftMost', () => {
    it('returns the left most atom in a nested list', () => {
        assert.strictEqual(leftMost([['potato'], ['chips', [['with'], 'fish'], ['chips']]]), 'potato');
        assert.strictEqual(leftMost([[['hot'], ['tuna', ['and']]], 'cheese']), 'hot');
    });
});

describe('isDeepEqual', () => {
    it('compares two nested lists for equality', () => {
        assert.strictEqual(isDeepEqual(['strawberry', 'ice', 'cream'], ['strawberry', 'cream', 'ice']), false);
        assert.strictEqual(isDeepEqual(['banana', [['split']]], [['banana'], ['split']]), false);
        assert.strictEqual(isDeepEqual(['beef', [['sausage']], ['and', ['soda']]], ['beef', [['salami']], ['and', ['soda']]]), false);
        assert.strictEqual(isDeepEqual(['beef', [['sausage']], ['and', ['soda']]], ['beef', [['sausage']], ['and', ['soda']]]), true);
    });
});

describe('removeMember2', () => {
    it('removes the first matching member', () => {
        assert.deepStrictEqual(removeMember2('and', ['bacon', 'lettuce', 'and', 'tomato']), ['bacon', 'lettuce', 'tomato']);
        assert.deepStrictEqual(removeMember2(['and'], ['bacon', 'lettuce', ['and'], 'tomato']), ['bacon', 'lettuce', 'tomato']);
    });
});

describe('isNumbered', () => {
    it('tests that an arithmetic expression contains only numbers', () => {
        assert.strictEqual(isNumbered([1, '+', 3]), true);
        assert.strictEqual(isNumbered([2, '*', 'sausage']), false);
        assert.strictEqual(isNumbered([3, '+', [4, '*', 5]]), true);
        assert.strictEqual(isNumbered([2, '*', ['sasuage', 'and', 'cheese']]), false);
    });
});

describe('value', () => {
    it('calculates the value of a numeric expression', () => {
        assert.strictEqual(value([1, '+', 3]), 4);
        assert.strictEqual(value([1, '+', [3, '^', 4]]), 82);
        assert.strictEqual(value([[3, '*', 6], '+', [8, '^', 2]]), 82);
    });
});

describe('isSet', () => {
    it('determines if the list is also a set', () => {
        assert.strictEqual(isSet(['apple', 'peaches', 'apple', 'plum']), false);
        assert.strictEqual(isSet(['apples', 'peaches', 'pears', 'plums']), true);
        assert.strictEqual(isSet([]), true);
        assert.strictEqual(isSet(['apple', 3, 'pear', 4, 9, 'apple', 3, 4]), false);
        assert.strictEqual(isSet(['apple', 3, 'pear', 4, 9]), true);
    });
});

describe('makeSet', () => {
    it('creates a set from a list', () => {
        assert.deepStrictEqual(makeSet(['apple', 'peach', 'pear', 'peach', 'plum', 'apple', 'lemon', 'peach']), ['pear', 'plum', 'apple', 'lemon', 'peach']);
    });
});

describe('makeSet2', () => {
    it('creates a set from a list', () => {
        assert.deepStrictEqual(makeSet2(['apple', 'peach', 'pear', 'peach', 'plum', 'apple', 'lemon', 'peach']), ['apple', 'peach', 'pear', 'plum', 'lemon']);
        assert.deepStrictEqual(makeSet2(['apple', 3, 'pear', 4, 9, 'apple', 3, 4]), ['apple', 3, 'pear', 4, 9]);
    });
});

describe('isSubset', () => {
    it('tests if one set is a subset of another', () => {
        assert.strictEqual(isSubset([5, 'chicken', 'wings'], [5, 'hamburgers', 2, 'pieces', 'fried', 'chicken', 'and', 'light', 'duckling', 'wings']), true);
        assert.strictEqual(isSubset([4, 'pounds', 'of', 'horseradish'], ['four', 'pounds', 'chicken', 'and', 5, 'ounces', 'horseradish']), false);
    });
});

describe('isEqualSets', () => {
    it('tests if two sets have the same members', () => {
        assert.strictEqual(isEqualSets([6, 'large', 'chickens', 'with', 'wings'], [6, 'chickens', 'with', 'large', 'wings']), true);
    });
});

describe('doesIntersect', () => {
    it('tests if at least one atom from one list is a member of another list', () => {
        assert.strictEqual(doesIntersect(['stewed', 'tomatoes', 'and', 'macaroni'], ['macaroni', 'and', 'cheese']), true);
    });
});

describe('intersect', () => {
    it('returns the intersection of two lists', () => {
        assert.deepStrictEqual(intersect(['stewed', 'tomato', 'and', 'macaroni'], ['macaroni', 'and', 'cheese']), ['and', 'macaroni']);
    });
});
