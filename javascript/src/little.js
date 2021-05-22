export const isAtom = (x) => !Array.isArray(x);

export const isEmpty = (l) => Array.isArray(l) && l.length === 0;

export const car = (l) => l[0];

export const cdr = (l) => l.slice(1);

export const cons = (a, l) => [a, ...l];

export const isListOfAtoms = (l) =>
    isEmpty(l) ? true
    : isAtom(car(l)) ? isListOfAtoms(cdr(l))
    : false;

export const isMember = (a, lat) =>
    isEmpty(lat) ? false
    : car(lat) === a || isMember(a, cdr(lat));

export const removeMember = (a, lat) =>
    isEmpty(lat) ? []
    : car(lat) === a ? cdr(lat)
    : cons(car(lat), removeMember(a, cdr(lat)));

export const firsts = (lat) =>
    isEmpty(lat) ? []
    : cons(car(car(lat)), firsts(cdr(lat)));

export const insertRight = (a, b, lat) =>
    isEmpty(lat) ? []
    : car(lat) === b ? cons(b, cons(a, cdr(lat)))
    : cons(car(lat), insertRight(a, b, cdr(lat)));

export const insertLeft = (a, b, lat) =>
    isEmpty(lat) ? []
    : car(lat) === b ? cons(a, lat)
    : cons(car(lat), insertLeft(a, b, cdr(lat)));

export const subst = (a, b, lat) =>
    isEmpty(lat) ? []
    : car(lat) === b ? cons(a, cdr(lat))
    : cons(car(lat), subst(a, b, cdr(lat)));

export const subst2 = (a, b1, b2, lat) =>
    isEmpty(lat) ? []
    : car(lat) === b1 || car(lat) === b2 ? cons(a, cdr(lat))
    : cons(car(lat), subst2(a, b1, b2, cdr(lat)));

export const multiRemoveMember = (a, lat) =>
    isEmpty(lat) ? []
    : car(lat) === a ? multiRemoveMember(a, cdr(lat))
    : cons(car(lat), multiRemoveMember(a, cdr(lat)));

export const multiInsertRight = (a, b, lat) =>
    isEmpty(lat) ? []
    : car(lat) === b ? cons(b, cons(a, multiInsertRight(a, b, cdr(lat))))
    : cons(car(lat), multiInsertRight(a, b, cdr(lat)));

export const multiInsertLeft = (a, b, lat) =>
    isEmpty(lat) ? []
    : car(lat) === b ? cons(a, cons(b, multiInsertLeft(a, b, cdr(lat))))
    : cons(car(lat), multiInsertLeft(a, b, cdr(lat)));

export const multiSubst = (a, b, lat) =>
    isEmpty(lat) ? []
    : car(lat) === b ? cons(a, multiSubst(a, b, cdr(lat)))
    : cons(car(lat), multiSubst(a, b, cdr(lat)));

export const add1 = (n) => n + 1;

export const sub1 = (n) => n - 1;

export const isZero = (n) => n === 0;

export const plus = (n, m) =>
    isZero(m) ? n
    : add1(plus(n, sub1(m)));

export const minus = (n, m) =>
    isZero(m) ? n
    : sub1(minus(n, sub1(m)));

export const addTup = (tup) =>
    isEmpty(tup) ? 0
    : plus(car(tup), addTup(cdr(tup)));

export const mult = (n, m) =>
    isZero(m) ? 0
    : plus(n, mult(n, sub1(m)));

export const tupPlus = (tup1, tup2) =>
    isEmpty(tup1) ? tup2
    : isEmpty(tup2) ? tup1
    : cons(plus(car(tup1), car(tup2)), tupPlus(cdr(tup1), cdr(tup2)));

export const isGreater = (n, m) =>
    isZero(n) ? false
    : isZero(m) ? true
    : isGreater(sub1(n), sub1(m));

export const isLess = (n, m) =>
    isZero(m) ? false
    : isZero(n) ? true
    : isLess(sub1(n), sub1(m));

export const isEqual = (n, m) =>
    isLess(n, m) ? false
    : isGreater(n, m) ? false
    : true;

export const expt = (n, m) =>
    isZero(m) ? 1
    : mult(n, expt(n, sub1(m)));

export const div = (n, m) =>
    isLess(n, m) ? 0
    : add1(div(minus(n, m), m));

export const length = (lat) =>
    isEmpty(lat) ? 0
    : add1(length(cdr(lat)));

export const isOne = (n) => isEqual(n, 1);

export const pick = (n, lat) =>
    isOne(n) ? car(lat)
    : pick(sub1(n), cdr(lat));

export const removePick = (n, lat) =>
    isOne(n) ? cdr(lat)
    : cons(car(lat), removePick(sub1(n), cdr(lat)));

export const isNumber = (n) => !isNaN(n);

export const noNums = (lat) =>
    isEmpty(lat) ? []
    : isNumber(car(lat)) ? noNums(cdr(lat))
    : cons(car(lat), noNums(cdr(lat)));

export const allNums = (lat) =>
    isEmpty(lat) ? []
    : isNumber(car(lat)) ? cons(car(lat), allNums(cdr(lat)))
    : allNums(cdr(lat));

export const occur = (a, lat) =>
    isEmpty(lat) ? 0
    : car(lat) === a ? add1(occur(a, cdr(lat)))
    : occur(a, cdr(lat));

export const removeMemberAll = (a, l) =>
    isEmpty(l) ? []
    : isAtom(car(l)) ?
        car(l) === a ? removeMemberAll(a, cdr(l))
        : cons(car(l), removeMemberAll(a, cdr(l)))
    : cons(removeMemberAll(a, car(l)), removeMemberAll(a, cdr(l)));

export const insertRightAll = (a, b, l) =>
    isEmpty(l) ? []
    : isAtom(car(l)) ?
        car(l) === b ? cons(b, cons(a, insertRightAll(a, b, cdr(l))))
        : cons(car(l), insertRightAll(a, b, cdr(l)))
    : cons(insertRightAll(a, b, car(l)), insertRightAll(a, b, cdr(l)));

export const occurAll = (a, l) =>
    isEmpty(l) ? 0
    : isAtom(car(l)) ?
        car(l) === a ? add1(occurAll(a, cdr(l)))
        : occurAll(a, cdr(l))
    : plus(occurAll(a, car(l)), occurAll(a, cdr(l)));

export const substAll = (a, b, l) =>
    isEmpty(l) ? []
    : isAtom(car(l)) ?
        car(l) === b ? cons(a, substAll(a, b, cdr(l)))
        : cons(car(l), substAll(a, b, cdr(l)))
    : cons(substAll(a, b, car(l)), substAll(a, b, cdr(l)));

export const insertLeftAll = (a, b, l) =>
    isEmpty(l) ? []
    : isAtom(car(l)) ?
        car(l) === b ? cons(a, cons(b, insertLeftAll(a, b, cdr(l))))
        : cons(car(l), insertLeftAll(a, b, cdr(l)))
    : cons(insertLeftAll(a, b, car(l)), insertLeftAll(a, b, cdr(l)));

export const memberAll = (a, l) =>
    isEmpty(l) ? false
    : isAtom(car(l)) ?
        car(l) === a ? true
        : memberAll(a, cdr(l))
    : memberAll(a, car(l)) || memberAll(a, cdr(l));

export const leftMost = (l) =>
    isAtom(car(l)) ? car(l)
    : leftMost(car(l));

export const isEqual2 = (s1, s2) =>
    isAtom(s1) && isAtom(s2) ? s1 === s2
    : isAtom(s1) || isAtom(s2) ? false
    : isDeepEqual(s1, s2);

export const isDeepEqual = (l1, l2) =>
    isEmpty(l1) && isEmpty(l2) ? true
    : isEmpty(l1) || isEmpty(l2) ? false
    : isEqual2(car(l1), car(l2)) && isDeepEqual(cdr(l1), cdr(l2));

export const removeMember2 = (s, l) =>
    isEmpty(l) ? []
    : isEqual2(car(l), s) ? cdr(l)
    : cons(car(l), removeMember2(s, cdr(l)));
