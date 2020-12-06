class Group {
    persons: Set<String>[];
    answered_any: Set<String>;
    answered_all: Set<String>;
    
    constructor(input: string) {
        this.persons = input.split("\n")
            .filter(l => l)
            .map(l => new Set(l.split('')));

        this.answered_any = new Set(this.persons.map(s => [...s]).flat());

        this.answered_all = new Set([...this.answered_any]
            .filter(a => this.persons
                .every(p => p.has(a))));
    }
}

class Solution {
    groups: Group[];
    constructor(input: string) {
        this.groups = input.split("\n\n")
            .map(l => new Group(l));
    }

    part1_solve(): number {
        return this.groups
            .map(g => g.answered_any.size)
            .reduce((sum, current) => sum + current);
    }

    part2_solve(): number {
        return this.groups
            .map(g => g.answered_all.size)
            .reduce((sum, current) => sum + current);
    }
}

export {Solution}