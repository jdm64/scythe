.pragma library

var Actions = Object.freeze({"Bolster": "ActionBolster.qml", "Move": "ActionMove.qml",
                            "Trade": "ActionTrade.qml", "Produce": "ActionProduce.qml",
                            "Bottom": "ActionBottom.qml", "Center": "ActionCenter.qml"});

var Boards = Object.freeze({
    "Engineering": // 2h, 5c
      [ newCard(Actions.Produce, newBottom("Upgrade", 3, 1, 2)),
        newCard(Actions.Trade,   newBottom("Deploy",  4, 2, 0)),
        newCard(Actions.Bolster, newBottom("Build",   3, 2, 3)),
        newCard(Actions.Move,    newBottom("Enlist",  3, 1, 1)) ],
    "Mechanical": // 3h, 6c
      [ newCard(Actions.Trade,   newBottom("Upgrade", 3, 1, 0)),
        newCard(Actions.Bolster, newBottom("Deploy",  3, 2, 2)),
        newCard(Actions.Move,    newBottom("Build",   3, 1, 2)),
        newCard(Actions.Produce, newBottom("Enlist",  4, 2, 2)) ],
    "Agricultural": // 4h, 7c
      [ newCard(Actions.Move,    newBottom("Upgrade", 3, 0, 1)),
        newCard(Actions.Trade,   newBottom("Deploy",  4, 2, 0)),
        newCard(Actions.Produce, newBottom("Build",   4, 2, 2)),
        newCard(Actions.Bolster, newBottom("Enlist",  3, 2, 3)) ],
    "Patriotic": // 2h, 6c
      [ newCard(Actions.Move,    newBottom("Upgrade", 2, 0, 1)),
        newCard(Actions.Bolster, newBottom("Deploy",  4, 3, 3)),
        newCard(Actions.Trade,   newBottom("Build",   4, 2, 0)),
        newCard(Actions.Produce, newBottom("Enlist",  3, 1, 2)) ],
    "Industrial": // 2h, 4c
      [ newCard(Actions.Bolster, newBottom("Upgrade", 3, 1, 3)),
        newCard(Actions.Produce, newBottom("Deploy",  3, 2, 2)),
        newCard(Actions.Move,    newBottom("Build",   3, 1, 1)),
        newCard(Actions.Trade,   newBottom("Enlist",  4, 2, 0)) ],
    "Militant": // 2h, 4c
      [ newCard(Actions.Bolster, newBottom("Upgrade", 3, 2, 0)),
        newCard(Actions.Move,    newBottom("Deploy",  3, 1, 3)),
        newCard(Actions.Produce, newBottom("Build",   4, 1, 1)),
        newCard(Actions.Trade,   newBottom("Enlist",  3, 2, 2)) ],
    "Innovative": // 3h, 5c
      [ newCard(Actions.Trade,   newBottom("Upgrade", 3, 0, 3)),
        newCard(Actions.Produce, newBottom("Deploy",  3, 1, 1)),
        newCard(Actions.Bolster, newBottom("Build",   4, 3, 2)),
        newCard(Actions.Move,    newBottom("Enlist",  3, 2, 0)) ],
});

/**
 * Creates a new normal action card with top and bottom actions.
 * The top action has no settings and the bottom action is the same with settings.
 */
function newCard(topAction, bottomSettings)
{
    return {"t": {"f": topAction, "s": {}},
            "b": {"f": Actions.Bottom, "s" : bottomSettings} };
}

function newBottom(atype, cost, upgrade, payout)
{
    return {"atype": atype, "cost": cost, "upgrade": upgrade, "payout": payout};
}

function addItem(parent, file, settings)
{
    Qt.createComponent(file).createObject(parent, settings);
}

/**
 * {"f": <file>, "s": <settings>}
 */
function loadCard(card, topAction, bottomAction)
{
    addItem(card, topAction.f, {});
    addItem(card, Actions.Center, {});
    addItem(card, bottomAction.f, bottomAction.s);
}

function getBoard(boardName)
{
    return Boards[boardName];
}
