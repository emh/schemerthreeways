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

export const isNumbered = (aexp) =>
    isAtom(aexp) ? isNumber(aexp)
    : isNumbered(car(aexp)) && isNumbered(car(cdr(cdr(aexp))));

export const firstSubExp = (nexp) => car(nexp);

export const operator = (nexp) => car(cdr(nexp));

export const secondSubExp = (nexp) => car(cdr(cdr(nexp)));

export const value = (nexp) =>
    isAtom(nexp) ? nexp
    : operator(nexp) === '+' ? plus(value(firstSubExp(nexp)), value(secondSubExp(nexp)))
    : operator(nexp) === '-' ? minus(value(firstSubExp(nexp)), value(secondSubExp(nexp)))
    : operator(nexp) === '*' ? mult(value(firstSubExp(nexp)), value(secondSubExp(nexp)))
    : expt(value(firstSubExp(nexp)), value(secondSubExp(nexp)));

export const isSet = (lat) =>
    isEmpty(lat) ? true
    : isMember(car(lat), cdr(lat)) ? false
    : isSet(cdr(lat));

export const makeSet = (lat) =>
    isEmpty(lat) ? []
    : isMember(car(lat), cdr(lat)) ? makeSet(cdr(lat))
    : cons(car(lat), makeSet(cdr(lat)));

export const makeSet2 = (lat) =>
    isEmpty(lat) ? []
    : cons(car(lat), multiRemoveMember(car(lat), makeSet2(cdr(lat))));

export const isSubset = (set1, set2) =>
    isEmpty(set1) ? true
    : isMember(car(set1), set2) && isSubset(cdr(set1), set2);

export const isEqualSets = (set1, set2) => isSubset(set1, set2) && isSubset(set2, set1);

export const doesIntersect = (set1, set2) =>
    isEmpty(set1) ? false
    : isMember(car(set1), set2) || doesIntersect(cdr(set1), set2);

export const intersect = (set1, set2) =>
    isEmpty(set1) ? []
    : isMember(car(set1), set2) ? cons(car(set1), intersect(cdr(set1), set2))
    : intersect(cdr(set1), set2);

export const union = (set1, set2) =>
    isEmpty(set1) ? set2
    : isMember(car(set1), set2) ? union(cdr(set1), set2)
    : cons(car(set1), union(cdr(set1), set2));

export const difference = (set1, set2) =>
    isEmpty(set1) ? []
    : isMember(car(set1), set2) ? difference(cdr(set1), set2)
    : cons(car(set1), difference(cdr(set1), set2));

export const intersectAll = (sets) =>
    isEmpty(cdr(sets)) ? car(sets)
    : intersect(car(sets), intersectAll(cdr(sets)));

export const isAPair = (l) =>
    isAtom(l) ? false
    : isEmpty(l) ? false
    : isEmpty(cdr(l)) ? false
    : isEmpty(cdr(cdr(l))) ? true
    : false;

export const isFun = (rel) => isSet(firsts(rel));

export const build = (s1, s2) => cons(s1, cons(s2, []));

export const first = car;

export const second = (pair) => car(cdr(pair));

export const revPair = (pair) => build(second(pair), car(pair));

export const revRel = (rel) =>
    isEmpty(rel) ? []
    : cons(revPair(car(rel)), revRel(cdr(rel)));

export const seconds = (lat) =>
    isEmpty(lat) ? []
    : cons(second(car(lat)), seconds(cdr(lat)));

export const isFullFun = (fun) => isSet(seconds(fun));

export const isOneToOne = (fun) => isFun(revRel(fun));

export const removeMemberFn = (fn, a, l) =>
    isEmpty(l) ? []
    : fn(car(l), a) ? cdr(l)
    : cons(car(l), removeMemberFn(fn, a, cdr(l)));

export const isEqualC = (a) => (x) => a === x;

export const removeMemberFn2 = (fn) =>
    (a, l) =>
        isEmpty(l) ? []
        : fn(car(l), a) ? cdr(l)
        : cons(car(l), removeMemberFn2(fn)(a, cdr(l)));

export const insertG = (seqFn) =>
    (a, b, l) =>
        isEmpty(l) ? []
        : car(l) === b ? seqFn(a, b, cdr(l))
        : cons(car(l), insertG(seqFn)(a, b, cdr(l)));

export const insertRight2 = insertG((a, b, l) => cons(b, cons(a, l)));

export const insertLeft2 = insertG((a, b, l) => cons(a, cons(b, l)));

export const subst3 = insertG((a, b, l) => cons(a, l));

export const removeMember3 = (a, l) => insertG((a, b, l) => l)(false, a, l);

export const multiRemoveMemberCo = (a, lat, col) =>
    isEmpty(lat) ? col([], [])
    : car(lat) === a ?
        multiRemoveMemberCo(a, cdr(lat), (newlat, seen) => col(newlat, cons(car(lat), seen)))
    : multiRemoveMemberCo(a, cdr(lat), (newlat, seen) => col(cons(car(lat), newlat), seen));

export const multiInsertLeftRightCo = (n, oldL, oldR, lat, col) =>
    isEmpty(lat) ? col([], 0, 0)
    : car(lat) === oldL ?
        multiInsertLeftRightCo(n, oldL, oldR, cdr(lat), (newlat, numL, numR) => col(cons(n, cons(oldL, newlat)), add1(numL), numR))
    : car(lat) === oldR ?
        multiInsertLeftRightCo(n, oldL, oldR, cdr(lat), (newlat, numL, numR) => col(cons(oldR, cons(n, newlat)), numL, add1(numR)))
    : multiInsertLeftRightCo(n, oldL, oldR, cdr(lat), (newlat, numL, numR) => col(cons(car(lat), newlat), numL, numR));

export const isEven = (n) => n % 2 === 0;

export const evensOnlyAll = (l) =>
    isEmpty(l) ? []
    : isAtom(car(l)) ?
        isEven(car(l)) ? cons(car(l), evensOnlyAll(cdr(l)))
        : evensOnlyAll(cdr(l))
    : cons(evensOnlyAll(car(l)), evensOnlyAll(cdr(l)));

export const evensOnlyAllCo = (l, col) =>
    isEmpty(l) ? col([], 1, 0)
    : isAtom(car(l)) ?
        isEven(car(l)) ? evensOnlyAllCo(cdr(l), (nl, p, s) => col(cons(car(l), nl), p * car(l), s))
        : evensOnlyAllCo(cdr(l), (nl, p, s) => col(nl, p, s + car(l)))
    : evensOnlyAllCo(car(l), (al, ap, as) => evensOnlyAllCo(cdr(l), (dl, dp, ds) => col(cons(al, dl), ap * dp, as + ds)));

export const keepLooking = (a, sorn, lat) => isNumber(sorn) ? keepLooking(a, pick(sorn, lat), lat) : sorn === a;

export const looking = (a, lat) => keepLooking(a, pick(1, lat), lat);

export const shift = (pair) => build(car(car(pair)), build(second(car(pair)), second(pair)));

export const weightAll = (pora) =>
    isAtom(pora) ? 1
    : (weightAll(car(pora)) * 2) + weightAll(second(pora));

export const Y = (le) => ((f) => f(f))((f) => le((x) => (f(f))(x)));

export const newEntry = build;

export const lookupInEntryHelp = (name, names, values, entryFn) =>
    isEmpty(names) ? entryFn(name)
    : car(names) === name ? car(values)
    : lookupInEntryHelp(name, cdr(names), cdr(values), entryFn);

export const lookupInEntry = (name, entry, entryFn) =>
    lookupInEntryHelp(name, first(entry), second(entry), entryFn);

export const extendTable = cons;

export const lookupInTable = (name, table, tableFn) =>
    isEmpty(table) ? tableFn(name)
    : lookupInEntry(name, car(table), (name) => lookupInTable(name, cdr(table), tableFn));
