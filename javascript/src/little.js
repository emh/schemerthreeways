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
