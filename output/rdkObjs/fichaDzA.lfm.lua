require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_DzA()
    local obj = GUI.fromHandle(_obj_newObject("form"));
    local self = obj;
    local sheet = nil;

    rawset(obj, "_oldSetNodeObjectFunction", obj.setNodeObject);

    function obj:setNodeObject(nodeObject)
        sheet = nodeObject;
        self.sheet = nodeObject;
        self:_oldSetNodeObjectFunction(nodeObject);
    end;

    function obj:setNodeDatabase(nodeObject)
        self:setNodeObject(nodeObject);
    end;

    _gui_assignInitialParentForForm(obj.handle);
    obj:beginUpdate();
    obj:setFormType("sheetTemplate");
    obj:setDataType("DATA_TYPE_AQUI");
    obj:setTitle("Dementes e Árduos");
    obj:setName("DzA");

    obj.style = GUI.fromHandle(_obj_newObject("form"));
    obj.style:setParent(obj);
    obj.style:setFormType("sheetTemplate");
    obj.style:setDataType("DATA_TYPE_AQUI");
    obj.style:setTitle("Dementes e Árduos");
    obj.style:setName("style");

    obj.script = GUI.fromHandle(_obj_newObject("form"));
    obj.script:setParent(obj);
    obj.script:setFormType("sheetTemplate");
    obj.script:setDataType("DATA_TYPE_AQUI");
    obj.script:setTitle("Dementes e Árduos");
    obj.script:setName("script");

    obj.dataLink1 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink1:setParent(obj.script);
    obj.dataLink1:setFields({'sorte', 'sorteMod'});
    obj.dataLink1:setName("dataLink1");


            local function dadoPadrao(nome,teste, rolagemTest, modificador)
                    local rolagem = Firecast.interpretarRolagem(sheet.rolagemTest); 
                    local testeValue = tonumber(teste) or 0;
                    
                    if not rolagem.possuiAlgumDado then                        
                        if testeValue == 1  then
                            rolagem = Firecast.interpretarRolagem("1d6"):concatenar(rolagem);
                        elseif testeValue == 2  then
                            rolagem = Firecast.interpretarRolagem("1d6"):concatenar(rolagem);
                        elseif testeValue == 3  then
                            rolagem = Firecast.interpretarRolagem("1d6"):concatenar(rolagem);
                        elseif testeValue == 4  then
                            rolagem = Firecast.interpretarRolagem("1d6"):concatenar(rolagem);
                        else
                            if testeValue % 2 == 0 then
                                testeValue = testeValue + 2;
                                local testeValueString = tostring(testeValue);
                                rolagem = Firecast.interpretarRolagem("1d" .. testeValueString):concatenar(rolagem);
                            else
                                testeValue = testeValue + 3;
                                local testeValueString = tostring(testeValue);
                                rolagem = Firecast.interpretarRolagem("1d" .. testeValueString):concatenar(rolagem);
                            end               
                        end
                    end

                    local mesaDoPersonagem = Firecast.getMesaDe(sheet);

                    if mesaDoPersonagem ~= nil and modificador == nil then
                        mesaDoPersonagem.chat:rolarDados(rolagem, nome .. " (" .. teste .. ")");
                    else
                        mesaDoPersonagem.chat:rolarDados(rolagem, nome .. " (" .. teste .. ") - Mod: " .. modificador);
                    end;
            end;

            local function dado20(nome, teste, rolagemTest)
                local rolagem = Firecast.interpretarRolagem(sheet.rolagemTest);

                if not rolagem.possuiAlgumDado then
                    rolagem = Firecast.interpretarRolagem("1d20"):concatenar(rolagem);
                end

                local mesaDoPersonagem = Firecast.getMesaDe(sheet);

                if mesaDoPersonagem ~= nil and modificador == nil then
                    mesaDoPersonagem.chat:rolarDados(rolagem, nome .. " (" .. teste .. ")");
                end;
            end;

            local function exibirMensagem()        
                    local texto = "";

                    for i = 1, 5, 1 do
                        texto = texto .. "Linha " .. i .. "\n";
                    end;                   

                    showMessage(texto);
            end;

            function askForDeletion(sheet, messageBox, messageConfirm)
                Dialogs.confirmYesNo(messageBox,
                    function (confirmado)
                            if confirmado then
                                    ndb.deleteNode(sheet);
                                    showMessage(messageConfirm);
                            end;
                    end);
            end
    


    obj.tabControl1 = GUI.fromHandle(_obj_newObject("tabControl"));
    obj.tabControl1:setParent(obj);
    obj.tabControl1.grid.role = "col";
    obj.tabControl1.grid.width = 12;
    obj.tabControl1:setHeight(500);
    obj.tabControl1:setName("tabControl1");

    obj.tab1 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab1:setParent(obj.tabControl1);
    obj.tab1:setTitle("Ficha");
    obj.tab1:setName("tab1");

    obj.layout1 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout1:setParent(obj.tab1);
    obj.layout1.grid.role = "col";
    obj.layout1.grid.width = 2;
    obj.layout1:setHeight(450);
    obj.layout1:setMargins({top=10});
    obj.layout1:setName("layout1");

    obj.layout2 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout2:setParent(obj.layout1);
    obj.layout2:setLeft(20);
    obj.layout2:setTop(20);
    obj.layout2:setHeight(25);
    obj.layout2.grid.role = "block";
    obj.layout2:setWidth(450);
    obj.layout2:setName("layout2");

    obj.label1 = GUI.fromHandle(_obj_newObject("label"));
    obj.label1:setParent(obj.layout2);
    obj.label1:setAlign("left");
    obj.label1:setText("Teste");
    obj.label1:setWidth(40);
    obj.label1:setHitTest(true);
    obj.label1:setMargins({right=5});
    obj.label1:setHint("Testes físicos do seu personagem");
    obj.label1:setName("label1");

    obj.label2 = GUI.fromHandle(_obj_newObject("label"));
    obj.label2:setParent(obj.layout2);
    obj.label2:setAlign("left");
    obj.label2:setText("Valor");
    obj.label2:setWidth(40);
    obj.label2:setHitTest(true);
    obj.label2:setName("label2");

    obj.label3 = GUI.fromHandle(_obj_newObject("label"));
    obj.label3:setParent(obj.layout2);
    obj.label3:setAlign("left");
    obj.label3:setText("Mod");
    obj.label3:setWidth(40);
    obj.label3:setHitTest(true);
    obj.label3:setHint("Modificador somado ao teste");
    obj.label3:setMargins({left=-4});
    obj.label3:setName("label3");

    obj.layout3 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout3:setParent(obj.layout1);
    obj.layout3:setLeft(20);
    obj.layout3:setTop(20);
    obj.layout3:setHeight(25);
    obj.layout3.grid.role = "block";
    obj.layout3:setName("layout3");
    obj.layout3:setWidth(450);
    obj.layout3:setMargins({top=10});

    obj.label4 = GUI.fromHandle(_obj_newObject("label"));
    obj.label4:setParent(obj.layout3);
    obj.label4:setAlign("left");
    obj.label4:setText("Sorte");
    obj.label4:setWidth(40);
    obj.label4:setHitTest(true);
    obj.label4:setHint("Quão cagado tu és");
    obj.label4:setName("label4");

    obj.edit1 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit1:setParent(obj.layout3);
    obj.edit1:setAlign("left");
    obj.edit1:setHorzTextAlign("center");
    obj.edit1:setField("sorte");
    obj.edit1:setName("edit1");
    obj.edit1:setWidth(30);
    obj.edit1:setMargins({left=5});

    obj.edit2 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit2:setParent(obj.layout3);
    obj.edit2:setAlign("left");
    obj.edit2:setHorzTextAlign("center");
    obj.edit2:setField("sorteMod");
    obj.edit2:setName("edit2");
    obj.edit2:setWidth(30);
    obj.edit2:setMargins({left=5});

    obj.button1 = GUI.fromHandle(_obj_newObject("button"));
    obj.button1:setParent(obj.layout3);
    obj.button1:setName("button1");
    obj.button1:setWidth(40);
    obj.button1:setText("rolar");
    obj.button1:setCursor("handPoint");
    obj.button1.grid.role = "block";
    obj.button1:setHeight(25);
    obj.button1:setMargins({left=6});

    obj.layout4 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout4:setParent(obj.layout1);
    obj.layout4:setLeft(20);
    obj.layout4:setTop(20);
    obj.layout4:setHeight(25);
    obj.layout4.grid.role = "block";
    obj.layout4:setName("layout4");
    obj.layout4:setWidth(450);
    obj.layout4:setMargins({top=10});

    obj.label5 = GUI.fromHandle(_obj_newObject("label"));
    obj.label5:setParent(obj.layout4);
    obj.label5:setAlign("left");
    obj.label5:setText("Vital");
    obj.label5:setWidth(40);
    obj.label5:setHitTest(true);
    obj.label5:setHint("Quantidade de energia vital");
    obj.label5:setName("label5");

    obj.edit3 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit3:setParent(obj.layout4);
    obj.edit3:setAlign("left");
    obj.edit3:setHorzTextAlign("center");
    obj.edit3:setField("vital");
    obj.edit3:setName("edit3");
    obj.edit3:setWidth(30);
    obj.edit3:setMargins({left=5});

    obj.edit4 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit4:setParent(obj.layout4);
    obj.edit4:setAlign("left");
    obj.edit4:setHorzTextAlign("center");
    obj.edit4:setField("vitalMod");
    obj.edit4:setName("edit4");
    obj.edit4:setWidth(30);
    obj.edit4:setMargins({left=5});

    obj.button2 = GUI.fromHandle(_obj_newObject("button"));
    obj.button2:setParent(obj.layout4);
    obj.button2:setName("button2");
    obj.button2:setWidth(40);
    obj.button2:setText("rolar");
    obj.button2:setCursor("handPoint");
    obj.button2.grid.role = "block";
    obj.button2:setHeight(25);
    obj.button2:setMargins({left=6});

    obj.layout5 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout5:setParent(obj.layout1);
    obj.layout5:setLeft(20);
    obj.layout5:setTop(20);
    obj.layout5:setHeight(25);
    obj.layout5.grid.role = "block";
    obj.layout5:setName("layout5");
    obj.layout5:setWidth(450);
    obj.layout5:setMargins({top=10});

    obj.label6 = GUI.fromHandle(_obj_newObject("label"));
    obj.label6:setParent(obj.layout5);
    obj.label6:setAlign("left");
    obj.label6:setText("Adre");
    obj.label6:setWidth(40);
    obj.label6:setHitTest(true);
    obj.label6:setHint("Habilidade de reação");
    obj.label6:setName("label6");

    obj.edit5 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit5:setParent(obj.layout5);
    obj.edit5:setAlign("left");
    obj.edit5:setHorzTextAlign("center");
    obj.edit5:setField("adrenalina");
    obj.edit5:setName("edit5");
    obj.edit5:setWidth(30);
    obj.edit5:setMargins({left=5});

    obj.edit6 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit6:setParent(obj.layout5);
    obj.edit6:setAlign("left");
    obj.edit6:setHorzTextAlign("center");
    obj.edit6:setField("adrenalinaMod");
    obj.edit6:setName("edit6");
    obj.edit6:setWidth(30);
    obj.edit6:setMargins({left=5});

    obj.button3 = GUI.fromHandle(_obj_newObject("button"));
    obj.button3:setParent(obj.layout5);
    obj.button3:setName("button3");
    obj.button3:setWidth(40);
    obj.button3:setText("rolar");
    obj.button3:setCursor("handPoint");
    obj.button3.grid.role = "block";
    obj.button3:setHeight(25);
    obj.button3:setMargins({left=6});

    obj.layout6 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout6:setParent(obj.layout1);
    obj.layout6:setLeft(20);
    obj.layout6:setTop(20);
    obj.layout6:setHeight(25);
    obj.layout6.grid.role = "block";
    obj.layout6:setName("layout6");
    obj.layout6:setWidth(450);
    obj.layout6:setMargins({top=10});

    obj.label7 = GUI.fromHandle(_obj_newObject("label"));
    obj.label7:setParent(obj.layout6);
    obj.label7:setAlign("left");
    obj.label7:setText("Ataq");
    obj.label7:setWidth(40);
    obj.label7:setHitTest(true);
    obj.label7:setHint("Sucesso do seu ataque");
    obj.label7:setName("label7");

    obj.edit7 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit7:setParent(obj.layout6);
    obj.edit7:setAlign("left");
    obj.edit7:setHorzTextAlign("center");
    obj.edit7:setField("ataque");
    obj.edit7:setName("edit7");
    obj.edit7:setWidth(30);
    obj.edit7:setMargins({left=5});

    obj.edit8 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit8:setParent(obj.layout6);
    obj.edit8:setAlign("left");
    obj.edit8:setHorzTextAlign("center");
    obj.edit8:setField("ataqueMod");
    obj.edit8:setName("edit8");
    obj.edit8:setWidth(30);
    obj.edit8:setMargins({left=5});

    obj.button4 = GUI.fromHandle(_obj_newObject("button"));
    obj.button4:setParent(obj.layout6);
    obj.button4:setName("button4");
    obj.button4:setWidth(40);
    obj.button4:setText("rolar");
    obj.button4:setCursor("handPoint");
    obj.button4.grid.role = "block";
    obj.button4:setHeight(25);
    obj.button4:setMargins({left=6});

    obj.layout7 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout7:setParent(obj.layout1);
    obj.layout7:setLeft(20);
    obj.layout7:setTop(20);
    obj.layout7:setHeight(25);
    obj.layout7.grid.role = "block";
    obj.layout7:setName("layout7");
    obj.layout7:setWidth(450);
    obj.layout7:setMargins({top=10});

    obj.label8 = GUI.fromHandle(_obj_newObject("label"));
    obj.label8:setParent(obj.layout7);
    obj.label8:setAlign("left");
    obj.label8:setText("Defe");
    obj.label8:setWidth(40);
    obj.label8:setHitTest(true);
    obj.label8:setHint("Sucesso da sua defesa");
    obj.label8:setName("label8");

    obj.edit9 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit9:setParent(obj.layout7);
    obj.edit9:setAlign("left");
    obj.edit9:setHorzTextAlign("center");
    obj.edit9:setField("defesa");
    obj.edit9:setName("edit9");
    obj.edit9:setWidth(30);
    obj.edit9:setMargins({left=5});

    obj.edit10 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit10:setParent(obj.layout7);
    obj.edit10:setAlign("left");
    obj.edit10:setHorzTextAlign("center");
    obj.edit10:setField("defesaMod");
    obj.edit10:setName("edit10");
    obj.edit10:setWidth(30);
    obj.edit10:setMargins({left=5});

    obj.button5 = GUI.fromHandle(_obj_newObject("button"));
    obj.button5:setParent(obj.layout7);
    obj.button5:setName("button5");
    obj.button5:setWidth(40);
    obj.button5:setText("rolar");
    obj.button5:setCursor("handPoint");
    obj.button5.grid.role = "block";
    obj.button5:setHeight(25);
    obj.button5:setMargins({left=6});

    obj.layout8 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout8:setParent(obj.layout1);
    obj.layout8:setLeft(20);
    obj.layout8:setTop(20);
    obj.layout8:setHeight(25);
    obj.layout8.grid.role = "block";
    obj.layout8:setName("layout8");
    obj.layout8:setWidth(450);
    obj.layout8:setMargins({top=10});

    obj.label9 = GUI.fromHandle(_obj_newObject("label"));
    obj.label9:setParent(obj.layout8);
    obj.label9:setAlign("left");
    obj.label9:setText("Dest");
    obj.label9:setWidth(40);
    obj.label9:setHitTest(true);
    obj.label9:setHint("Define a precisão de suas ações");
    obj.label9:setName("label9");

    obj.edit11 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit11:setParent(obj.layout8);
    obj.edit11:setAlign("left");
    obj.edit11:setHorzTextAlign("center");
    obj.edit11:setField("destreza");
    obj.edit11:setName("edit11");
    obj.edit11:setWidth(30);
    obj.edit11:setMargins({left=5});

    obj.edit12 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit12:setParent(obj.layout8);
    obj.edit12:setAlign("left");
    obj.edit12:setHorzTextAlign("center");
    obj.edit12:setField("destrezaMod");
    obj.edit12:setName("edit12");
    obj.edit12:setWidth(30);
    obj.edit12:setMargins({left=5});

    obj.button6 = GUI.fromHandle(_obj_newObject("button"));
    obj.button6:setParent(obj.layout8);
    obj.button6:setName("button6");
    obj.button6:setWidth(40);
    obj.button6:setText("rolar");
    obj.button6:setCursor("handPoint");
    obj.button6.grid.role = "block";
    obj.button6:setHeight(25);
    obj.button6:setMargins({left=6});

    obj.layout9 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout9:setParent(obj.layout1);
    obj.layout9:setLeft(20);
    obj.layout9:setTop(20);
    obj.layout9:setHeight(25);
    obj.layout9.grid.role = "block";
    obj.layout9:setName("layout9");
    obj.layout9:setWidth(450);
    obj.layout9:setMargins({top=10});

    obj.label10 = GUI.fromHandle(_obj_newObject("label"));
    obj.label10:setParent(obj.layout9);
    obj.label10:setAlign("left");
    obj.label10:setText("Força");
    obj.label10:setWidth(40);
    obj.label10:setHitTest(true);
    obj.label10:setHint("Habilidade de vencer a inércia");
    obj.label10:setName("label10");

    obj.edit13 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit13:setParent(obj.layout9);
    obj.edit13:setAlign("left");
    obj.edit13:setHorzTextAlign("center");
    obj.edit13:setField("forca");
    obj.edit13:setName("edit13");
    obj.edit13:setWidth(30);
    obj.edit13:setMargins({left=5});

    obj.edit14 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit14:setParent(obj.layout9);
    obj.edit14:setAlign("left");
    obj.edit14:setHorzTextAlign("center");
    obj.edit14:setField("forcaMod");
    obj.edit14:setName("edit14");
    obj.edit14:setWidth(30);
    obj.edit14:setMargins({left=5});

    obj.button7 = GUI.fromHandle(_obj_newObject("button"));
    obj.button7:setParent(obj.layout9);
    obj.button7:setName("button7");
    obj.button7:setWidth(40);
    obj.button7:setText("rolar");
    obj.button7:setCursor("handPoint");
    obj.button7.grid.role = "block";
    obj.button7:setHeight(25);
    obj.button7:setMargins({left=6});

    obj.layout10 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout10:setParent(obj.layout1);
    obj.layout10:setLeft(20);
    obj.layout10:setTop(20);
    obj.layout10:setHeight(25);
    obj.layout10.grid.role = "block";
    obj.layout10:setName("layout10");
    obj.layout10:setWidth(450);
    obj.layout10:setMargins({top=10});

    obj.label11 = GUI.fromHandle(_obj_newObject("label"));
    obj.label11:setParent(obj.layout10);
    obj.label11:setAlign("left");
    obj.label11:setText("Inte");
    obj.label11:setWidth(40);
    obj.label11:setHitTest(true);
    obj.label11:setHint("Conhecimentos acadêmicos");
    obj.label11:setName("label11");

    obj.edit15 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit15:setParent(obj.layout10);
    obj.edit15:setAlign("left");
    obj.edit15:setHorzTextAlign("center");
    obj.edit15:setField("inteligencia");
    obj.edit15:setName("edit15");
    obj.edit15:setWidth(30);
    obj.edit15:setMargins({left=5});

    obj.edit16 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit16:setParent(obj.layout10);
    obj.edit16:setAlign("left");
    obj.edit16:setHorzTextAlign("center");
    obj.edit16:setField("inteligenciaMod");
    obj.edit16:setName("edit16");
    obj.edit16:setWidth(30);
    obj.edit16:setMargins({left=5});

    obj.button8 = GUI.fromHandle(_obj_newObject("button"));
    obj.button8:setParent(obj.layout10);
    obj.button8:setName("button8");
    obj.button8:setWidth(40);
    obj.button8:setText("rolar");
    obj.button8:setCursor("handPoint");
    obj.button8.grid.role = "block";
    obj.button8:setHeight(25);
    obj.button8:setMargins({left=6});

    obj.layout11 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout11:setParent(obj.layout1);
    obj.layout11:setLeft(20);
    obj.layout11:setTop(20);
    obj.layout11:setHeight(25);
    obj.layout11.grid.role = "block";
    obj.layout11:setName("layout11");
    obj.layout11:setWidth(450);
    obj.layout11:setMargins({top=10});

    obj.label12 = GUI.fromHandle(_obj_newObject("label"));
    obj.label12:setParent(obj.layout11);
    obj.label12:setAlign("left");
    obj.label12:setText("Resis");
    obj.label12:setWidth(40);
    obj.label12:setHitTest(true);
    obj.label12:setHint("Resiliência do seu personagem");
    obj.label12:setName("label12");

    obj.edit17 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit17:setParent(obj.layout11);
    obj.edit17:setAlign("left");
    obj.edit17:setHorzTextAlign("center");
    obj.edit17:setField("resistencia");
    obj.edit17:setName("edit17");
    obj.edit17:setWidth(30);
    obj.edit17:setMargins({left=5});

    obj.edit18 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit18:setParent(obj.layout11);
    obj.edit18:setAlign("left");
    obj.edit18:setHorzTextAlign("center");
    obj.edit18:setField("resistenciaMod");
    obj.edit18:setName("edit18");
    obj.edit18:setWidth(30);
    obj.edit18:setMargins({left=5});

    obj.button9 = GUI.fromHandle(_obj_newObject("button"));
    obj.button9:setParent(obj.layout11);
    obj.button9:setName("button9");
    obj.button9:setWidth(40);
    obj.button9:setText("rolar");
    obj.button9:setCursor("handPoint");
    obj.button9.grid.role = "block";
    obj.button9:setHeight(25);
    obj.button9:setMargins({left=6});

    obj.layout12 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout12:setParent(obj.layout1);
    obj.layout12:setLeft(20);
    obj.layout12:setTop(20);
    obj.layout12:setHeight(25);
    obj.layout12.grid.role = "block";
    obj.layout12:setName("layout12");
    obj.layout12:setWidth(450);
    obj.layout12:setMargins({top=10});

    obj.label13 = GUI.fromHandle(_obj_newObject("label"));
    obj.label13:setParent(obj.layout12);
    obj.label13:setAlign("left");
    obj.label13:setText("Sabe");
    obj.label13:setWidth(40);
    obj.label13:setHitTest(true);
    obj.label13:setHint("Experiência de vida");
    obj.label13:setName("label13");

    obj.edit19 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit19:setParent(obj.layout12);
    obj.edit19:setAlign("left");
    obj.edit19:setHorzTextAlign("center");
    obj.edit19:setField("sabedoria");
    obj.edit19:setName("edit19");
    obj.edit19:setWidth(30);
    obj.edit19:setMargins({left=5});

    obj.edit20 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit20:setParent(obj.layout12);
    obj.edit20:setAlign("left");
    obj.edit20:setHorzTextAlign("center");
    obj.edit20:setField("sabedoriaMod");
    obj.edit20:setName("edit20");
    obj.edit20:setWidth(30);
    obj.edit20:setMargins({left=5});

    obj.button10 = GUI.fromHandle(_obj_newObject("button"));
    obj.button10:setParent(obj.layout12);
    obj.button10:setName("button10");
    obj.button10:setWidth(40);
    obj.button10:setText("rolar");
    obj.button10:setCursor("handPoint");
    obj.button10.grid.role = "block";
    obj.button10:setHeight(25);
    obj.button10:setMargins({left=6});

    obj.layout13 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout13:setParent(obj.layout1);
    obj.layout13:setLeft(20);
    obj.layout13:setTop(20);
    obj.layout13:setHeight(25);
    obj.layout13.grid.role = "block";
    obj.layout13:setName("layout13");
    obj.layout13:setWidth(450);
    obj.layout13:setMargins({top=10});

    obj.label14 = GUI.fromHandle(_obj_newObject("label"));
    obj.label14:setParent(obj.layout13);
    obj.label14:setAlign("left");
    obj.label14:setText("Velo");
    obj.label14:setWidth(40);
    obj.label14:setHitTest(true);
    obj.label14:setHint("Velocidade que seu personagem executa ações");
    obj.label14:setName("label14");

    obj.edit21 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit21:setParent(obj.layout13);
    obj.edit21:setAlign("left");
    obj.edit21:setHorzTextAlign("center");
    obj.edit21:setField("velocidade");
    obj.edit21:setName("edit21");
    obj.edit21:setWidth(30);
    obj.edit21:setMargins({left=5});

    obj.edit22 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit22:setParent(obj.layout13);
    obj.edit22:setAlign("left");
    obj.edit22:setHorzTextAlign("center");
    obj.edit22:setField("velocidadeMod");
    obj.edit22:setName("edit22");
    obj.edit22:setWidth(30);
    obj.edit22:setMargins({left=5});

    obj.button11 = GUI.fromHandle(_obj_newObject("button"));
    obj.button11:setParent(obj.layout13);
    obj.button11:setName("button11");
    obj.button11:setWidth(40);
    obj.button11:setText("rolar");
    obj.button11:setCursor("handPoint");
    obj.button11.grid.role = "block";
    obj.button11:setHeight(25);
    obj.button11:setMargins({left=6});

    obj.layout14 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout14:setParent(obj.tab1);
    obj.layout14.grid.role = "col";
    obj.layout14.grid.width = 4;
    obj.layout14:setHeight(420);
    obj.layout14:setMargins({top=10});
    obj.layout14:setName("layout14");

    obj.layout15 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout15:setParent(obj.layout14);
    obj.layout15.grid.role = "block";
    obj.layout15:setHeight(25);
    obj.layout15:setName("layout15");
    obj.layout15:setWidth(450);

    obj.label15 = GUI.fromHandle(_obj_newObject("label"));
    obj.label15:setParent(obj.layout15);
    obj.label15:setAlign("left");
    obj.label15:setText("Informações do personagem");
    obj.label15:setWidth(300);
    obj.label15:setName("label15");

    obj.layout16 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout16:setParent(obj.layout14);
    obj.layout16.grid.role = "block";
    obj.layout16:setHeight(25);
    obj.layout16:setMargins({top=7});
    obj.layout16:setName("layout16");
    obj.layout16:setWidth(450);

    obj.label16 = GUI.fromHandle(_obj_newObject("label"));
    obj.label16:setParent(obj.layout16);
    obj.label16:setAlign("left");
    obj.label16:setText("Nome");
    obj.label16:setWidth(64);
    obj.label16:setHitTest(true);
    obj.label16:setHint("Nome do seu personagem");
    obj.label16:setName("label16");

    obj.edit23 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit23:setParent(obj.layout16);
    obj.edit23:setAlign("left");
    obj.edit23:setHorzTextAlign("leading");
    obj.edit23:setField("nomeChar");
    obj.edit23:setWidth(282);
    obj.edit23:setName("edit23");

    obj.layout17 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout17:setParent(obj.layout14);
    obj.layout17.grid.role = "block";
    obj.layout17:setHeight(25);
    obj.layout17:setMargins({top=6});
    obj.layout17:setName("layout17");
    obj.layout17:setWidth(450);

    obj.label17 = GUI.fromHandle(_obj_newObject("label"));
    obj.label17:setParent(obj.layout17);
    obj.label17:setAlign("left");
    obj.label17:setText("Raça");
    obj.label17:setWidth(64);
    obj.label17:setHitTest(true);
    obj.label17:setHint("Raça do seu personagem");
    obj.label17:setName("label17");

    obj.edit24 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit24:setParent(obj.layout17);
    obj.edit24:setAlign("left");
    obj.edit24:setHorzTextAlign("center");
    obj.edit24:setField("racaChar");
    obj.edit24:setWidth(168);
    obj.edit24:setName("edit24");

    obj.label18 = GUI.fromHandle(_obj_newObject("label"));
    obj.label18:setParent(obj.layout17);
    obj.label18:setAlign("left");
    obj.label18:setText("Idade");
    obj.label18:setWidth(40);
    obj.label18:setHitTest(true);
    obj.label18:setMargins({left=6});
    obj.label18:setHint("Idade do seu personagem");
    obj.label18:setName("label18");

    obj.edit25 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit25:setParent(obj.layout17);
    obj.edit25:setAlign("left");
    obj.edit25:setHorzTextAlign("center");
    obj.edit25:setField("idadeChar");
    obj.edit25:setWidth(68);
    obj.edit25:setName("edit25");

    obj.layout18 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout18:setParent(obj.layout14);
    obj.layout18.grid.role = "block";
    obj.layout18:setHeight(25);
    obj.layout18:setMargins({top=6});
    obj.layout18:setName("layout18");
    obj.layout18:setWidth(450);

    obj.label19 = GUI.fromHandle(_obj_newObject("label"));
    obj.label19:setParent(obj.layout18);
    obj.label19:setAlign("left");
    obj.label19:setText("Tendência");
    obj.label19:setWidth(64);
    obj.label19:setHitTest(true);
    obj.label19:setHint("Alinhamento moral do seu personagem");
    obj.label19:setName("label19");

    obj.edit26 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit26:setParent(obj.layout18);
    obj.edit26:setAlign("left");
    obj.edit26:setHorzTextAlign("center");
    obj.edit26:setField("tendenciaChar");
    obj.edit26:setWidth(168);
    obj.edit26:setName("edit26");

    obj.label20 = GUI.fromHandle(_obj_newObject("label"));
    obj.label20:setParent(obj.layout18);
    obj.label20:setAlign("left");
    obj.label20:setText("Level");
    obj.label20:setWidth(40);
    obj.label20:setHitTest(true);
    obj.label20:setMargins({left=6});
    obj.label20:setHint("Level do seu personagem");
    obj.label20:setName("label20");

    obj.edit27 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit27:setParent(obj.layout18);
    obj.edit27:setAlign("left");
    obj.edit27:setHorzTextAlign("center");
    obj.edit27:setField("levelChar");
    obj.edit27:setWidth(68);
    obj.edit27:setName("edit27");

    obj.layout19 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout19:setParent(obj.layout14);
    obj.layout19.grid.role = "block";
    obj.layout19:setHeight(25);
    obj.layout19:setMargins({top=6});
    obj.layout19:setName("layout19");
    obj.layout19:setWidth(450);

    obj.label21 = GUI.fromHandle(_obj_newObject("label"));
    obj.label21:setParent(obj.layout19);
    obj.label21:setAlign("left");
    obj.label21:setText("Atual");
    obj.label21:setWidth(64);
    obj.label21:setHitTest(true);
    obj.label21:setHint("Xp atual do seu personagem");
    obj.label21:setName("label21");

    obj.edit28 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit28:setParent(obj.layout19);
    obj.edit28:setAlign("left");
    obj.edit28:setHorzTextAlign("center");
    obj.edit28:setField("atualXpChar");
    obj.edit28:setWidth(106);
    obj.edit28:setName("edit28");

    obj.label22 = GUI.fromHandle(_obj_newObject("label"));
    obj.label22:setParent(obj.layout19);
    obj.label22:setAlign("left");
    obj.label22:setText("Requer");
    obj.label22:setWidth(64);
    obj.label22:setHitTest(true);
    obj.label22:setMargins({left=6});
    obj.label22:setHint("Requerimento de XP para upar");
    obj.label22:setName("label22");

    obj.edit29 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit29:setParent(obj.layout19);
    obj.edit29:setAlign("left");
    obj.edit29:setHorzTextAlign("center");
    obj.edit29:setField("requerimentoXpChar");
    obj.edit29:setWidth(106);
    obj.edit29:setName("edit29");

    obj.layout20 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout20:setParent(obj.layout14);
    obj.layout20.grid.role = "block";
    obj.layout20:setHeight(25);
    obj.layout20:setMargins({top=6});
    obj.layout20:setName("layout20");
    obj.layout20:setWidth(450);

    obj.progressBar1 = GUI.fromHandle(_obj_newObject("progressBar"));
    obj.progressBar1:setParent(obj.layout20);
    obj.progressBar1:setWidth(282);
    obj.progressBar1:setLeft(64);
    obj.progressBar1:setHeight(15);
    obj.progressBar1:setColor("#4dff5e");
    obj.progressBar1:setMin(0);
    obj.progressBar1:setField("atualXpChar");
    obj.progressBar1:setFieldMax("requerimentoXpChar");
    obj.progressBar1:setName("progressBar1");

    obj.layout21 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout21:setParent(obj.layout14);
    obj.layout21.grid.role = "block";
    obj.layout21:setHeight(52);
    obj.layout21:setMargins({top=6});
    obj.layout21:setName("layout21");
    obj.layout21:setWidth(450);

    obj.label23 = GUI.fromHandle(_obj_newObject("label"));
    obj.label23:setParent(obj.layout21);
    obj.label23:setAlign("left");
    obj.label23:setText("Sanidade");
    obj.label23:setWidth(64);
    obj.label23:setHitTest(true);
    obj.label23:setHint("Precisa de um psi,psi...doutor???");
    obj.label23:setName("label23");

    obj.imageCheckBox1 = GUI.fromHandle(_obj_newObject("imageCheckBox"));
    obj.imageCheckBox1:setParent(obj.layout21);
    obj.imageCheckBox1:setWidth(52);
    obj.imageCheckBox1:setAlign("left");
    obj.imageCheckBox1:setImageChecked("/images/Caveira3.png");
    obj.imageCheckBox1:setImageUnchecked("/images/Caveira2.png");
    obj.imageCheckBox1:setField("sanidade1");
    obj.imageCheckBox1:setName("imageCheckBox1");

    obj.imageCheckBox2 = GUI.fromHandle(_obj_newObject("imageCheckBox"));
    obj.imageCheckBox2:setParent(obj.layout21);
    obj.imageCheckBox2:setWidth(52);
    obj.imageCheckBox2:setAlign("left");
    obj.imageCheckBox2:setMargins({left=6});
    obj.imageCheckBox2:setImageChecked("/images/Caveira3.png");
    obj.imageCheckBox2:setImageUnchecked("/images/Caveira2.png");
    obj.imageCheckBox2:setField("sanidade2");
    obj.imageCheckBox2:setName("imageCheckBox2");

    obj.imageCheckBox3 = GUI.fromHandle(_obj_newObject("imageCheckBox"));
    obj.imageCheckBox3:setParent(obj.layout21);
    obj.imageCheckBox3:setWidth(52);
    obj.imageCheckBox3:setAlign("left");
    obj.imageCheckBox3:setMargins({left=6});
    obj.imageCheckBox3:setImageChecked("/images/Caveira3.png");
    obj.imageCheckBox3:setImageUnchecked("/images/Caveira2.png");
    obj.imageCheckBox3:setField("sanidade3");
    obj.imageCheckBox3:setName("imageCheckBox3");

    obj.imageCheckBox4 = GUI.fromHandle(_obj_newObject("imageCheckBox"));
    obj.imageCheckBox4:setParent(obj.layout21);
    obj.imageCheckBox4:setWidth(52);
    obj.imageCheckBox4:setAlign("left");
    obj.imageCheckBox4:setMargins({left=6});
    obj.imageCheckBox4:setImageChecked("/images/Caveira3.png");
    obj.imageCheckBox4:setImageUnchecked("/images/Caveira2.png");
    obj.imageCheckBox4:setField("sanidade4");
    obj.imageCheckBox4:setName("imageCheckBox4");

    obj.imageCheckBox5 = GUI.fromHandle(_obj_newObject("imageCheckBox"));
    obj.imageCheckBox5:setParent(obj.layout21);
    obj.imageCheckBox5:setWidth(52);
    obj.imageCheckBox5:setAlign("left");
    obj.imageCheckBox5:setMargins({left=6});
    obj.imageCheckBox5:setImageChecked("/images/Caveira3.png");
    obj.imageCheckBox5:setImageUnchecked("/images/Caveira2.png");
    obj.imageCheckBox5:setField("sanidade5");
    obj.imageCheckBox5:setName("imageCheckBox5");

    obj.tabControl2 = GUI.fromHandle(_obj_newObject("tabControl"));
    obj.tabControl2:setParent(obj.layout14);
    obj.tabControl2.grid.role = "block";
    obj.tabControl2:setWidth(400);
    obj.tabControl2:setHeight(500);
    obj.tabControl2:setName("tabControl2");

    obj.layout22 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout22:setParent(obj.tabControl2);
    obj.layout22.grid.role = "block";
    obj.layout22:setHeight(25);
    obj.layout22:setMargins({top=12});
    obj.layout22:setName("layout22");
    obj.layout22:setWidth(450);

    obj.label24 = GUI.fromHandle(_obj_newObject("label"));
    obj.label24:setParent(obj.layout22);
    obj.label24:setAlign("right");
    obj.label24:setText("Teste");
    obj.label24:setWidth(64);
    obj.label24:setMargins({right=150});
    obj.label24:setName("label24");

    obj.tab2 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab2:setParent(obj.tabControl2);
    obj.tab2:setTitle("Desvantagens 1");
    obj.tab2:setName("tab2");

    obj.layout23 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout23:setParent(obj.tab2);
    obj.layout23.grid.role = "block";
    obj.layout23:setHeight(25);
    obj.layout23:setMargins({top=6});
    obj.layout23:setName("layout23");
    obj.layout23:setWidth(450);

    obj.edit30 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit30:setParent(obj.layout23);
    obj.edit30:setAlign("left");
    obj.edit30:setHorzTextAlign("leading");
    obj.edit30:setField("desvantagem1");
    obj.edit30:setWidth(204);
    obj.edit30:setName("edit30");

    obj.edit31 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit31:setParent(obj.layout23);
    obj.edit31:setAlign("left");
    obj.edit31:setHorzTextAlign("center");
    obj.edit31:setField("testeDesvantagem1");
    obj.edit31:setWidth(64);
    obj.edit31:setMargins({left=6});
    obj.edit31:setName("edit31");

    obj.button12 = GUI.fromHandle(_obj_newObject("button"));
    obj.button12:setParent(obj.layout23);
    obj.button12:setName("button12");
    obj.button12:setWidth(40);
    obj.button12:setText("rolar");
    obj.button12:setCursor("handPoint");
    obj.button12.grid.role = "block";
    obj.button12:setHeight(25);
    obj.button12:setMargins({left=6});

    obj.layout24 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout24:setParent(obj.tab2);
    obj.layout24.grid.role = "block";
    obj.layout24:setHeight(25);
    obj.layout24:setMargins({top=9});
    obj.layout24:setName("layout24");
    obj.layout24:setWidth(450);

    obj.edit32 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit32:setParent(obj.layout24);
    obj.edit32:setAlign("left");
    obj.edit32:setHorzTextAlign("leading");
    obj.edit32:setField("desvantagem2");
    obj.edit32:setWidth(204);
    obj.edit32:setName("edit32");

    obj.edit33 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit33:setParent(obj.layout24);
    obj.edit33:setAlign("left");
    obj.edit33:setHorzTextAlign("center");
    obj.edit33:setField("testeDesvantagem2");
    obj.edit33:setWidth(64);
    obj.edit33:setMargins({left=6});
    obj.edit33:setName("edit33");

    obj.button13 = GUI.fromHandle(_obj_newObject("button"));
    obj.button13:setParent(obj.layout24);
    obj.button13:setName("button13");
    obj.button13:setWidth(40);
    obj.button13:setText("rolar");
    obj.button13:setCursor("handPoint");
    obj.button13.grid.role = "block";
    obj.button13:setHeight(25);
    obj.button13:setMargins({left=6});

    obj.layout25 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout25:setParent(obj.tab2);
    obj.layout25.grid.role = "block";
    obj.layout25:setHeight(25);
    obj.layout25:setMargins({top=9});
    obj.layout25:setName("layout25");
    obj.layout25:setWidth(450);

    obj.edit34 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit34:setParent(obj.layout25);
    obj.edit34:setAlign("left");
    obj.edit34:setHorzTextAlign("leading");
    obj.edit34:setField("desvantagem3");
    obj.edit34:setWidth(204);
    obj.edit34:setName("edit34");

    obj.edit35 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit35:setParent(obj.layout25);
    obj.edit35:setAlign("left");
    obj.edit35:setHorzTextAlign("center");
    obj.edit35:setField("testeDesvantagem3");
    obj.edit35:setWidth(64);
    obj.edit35:setMargins({left=6});
    obj.edit35:setName("edit35");

    obj.button14 = GUI.fromHandle(_obj_newObject("button"));
    obj.button14:setParent(obj.layout25);
    obj.button14:setName("button14");
    obj.button14:setWidth(40);
    obj.button14:setText("rolar");
    obj.button14:setCursor("handPoint");
    obj.button14.grid.role = "block";
    obj.button14:setHeight(25);
    obj.button14:setMargins({left=6});

    obj.layout26 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout26:setParent(obj.tab2);
    obj.layout26.grid.role = "block";
    obj.layout26:setHeight(25);
    obj.layout26:setMargins({top=9});
    obj.layout26:setName("layout26");
    obj.layout26:setWidth(450);

    obj.edit36 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit36:setParent(obj.layout26);
    obj.edit36:setAlign("left");
    obj.edit36:setHorzTextAlign("leading");
    obj.edit36:setField("desvantagem4");
    obj.edit36:setWidth(204);
    obj.edit36:setName("edit36");

    obj.edit37 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit37:setParent(obj.layout26);
    obj.edit37:setAlign("left");
    obj.edit37:setHorzTextAlign("center");
    obj.edit37:setField("testeDesvantagem4");
    obj.edit37:setWidth(64);
    obj.edit37:setMargins({left=6});
    obj.edit37:setName("edit37");

    obj.button15 = GUI.fromHandle(_obj_newObject("button"));
    obj.button15:setParent(obj.layout26);
    obj.button15:setName("button15");
    obj.button15:setWidth(40);
    obj.button15:setText("rolar");
    obj.button15:setCursor("handPoint");
    obj.button15.grid.role = "block";
    obj.button15:setHeight(25);
    obj.button15:setMargins({left=6});

    obj.tab3 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab3:setParent(obj.tabControl2);
    obj.tab3:setTitle("Desvantagens 2");
    obj.tab3:setName("tab3");

    obj.layout27 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout27:setParent(obj.tab3);
    obj.layout27.grid.role = "block";
    obj.layout27:setHeight(25);
    obj.layout27:setMargins({top=6});
    obj.layout27:setName("layout27");
    obj.layout27:setWidth(450);

    obj.edit38 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit38:setParent(obj.layout27);
    obj.edit38:setAlign("left");
    obj.edit38:setHorzTextAlign("leading");
    obj.edit38:setField("desvantagem5");
    obj.edit38:setWidth(204);
    obj.edit38:setName("edit38");

    obj.edit39 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit39:setParent(obj.layout27);
    obj.edit39:setAlign("left");
    obj.edit39:setHorzTextAlign("center");
    obj.edit39:setField("testeDesvantagem5");
    obj.edit39:setWidth(64);
    obj.edit39:setMargins({left=6});
    obj.edit39:setName("edit39");

    obj.button16 = GUI.fromHandle(_obj_newObject("button"));
    obj.button16:setParent(obj.layout27);
    obj.button16:setName("button16");
    obj.button16:setWidth(40);
    obj.button16:setText("rolar");
    obj.button16:setCursor("handPoint");
    obj.button16.grid.role = "block";
    obj.button16:setHeight(25);
    obj.button16:setMargins({left=6});

    obj.layout28 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout28:setParent(obj.tab3);
    obj.layout28.grid.role = "block";
    obj.layout28:setHeight(25);
    obj.layout28:setMargins({top=9});
    obj.layout28:setName("layout28");
    obj.layout28:setWidth(450);

    obj.edit40 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit40:setParent(obj.layout28);
    obj.edit40:setAlign("left");
    obj.edit40:setHorzTextAlign("leading");
    obj.edit40:setField("desvantagem6");
    obj.edit40:setWidth(204);
    obj.edit40:setName("edit40");

    obj.edit41 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit41:setParent(obj.layout28);
    obj.edit41:setAlign("left");
    obj.edit41:setHorzTextAlign("center");
    obj.edit41:setField("testeDesvantagem6");
    obj.edit41:setWidth(64);
    obj.edit41:setMargins({left=6});
    obj.edit41:setName("edit41");

    obj.button17 = GUI.fromHandle(_obj_newObject("button"));
    obj.button17:setParent(obj.layout28);
    obj.button17:setName("button17");
    obj.button17:setWidth(40);
    obj.button17:setText("rolar");
    obj.button17:setCursor("handPoint");
    obj.button17.grid.role = "block";
    obj.button17:setHeight(25);
    obj.button17:setMargins({left=6});

    obj.layout29 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout29:setParent(obj.tab3);
    obj.layout29.grid.role = "block";
    obj.layout29:setHeight(25);
    obj.layout29:setMargins({top=9});
    obj.layout29:setName("layout29");
    obj.layout29:setWidth(450);

    obj.edit42 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit42:setParent(obj.layout29);
    obj.edit42:setAlign("left");
    obj.edit42:setHorzTextAlign("leading");
    obj.edit42:setField("desvantagem7");
    obj.edit42:setWidth(204);
    obj.edit42:setName("edit42");

    obj.edit43 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit43:setParent(obj.layout29);
    obj.edit43:setAlign("left");
    obj.edit43:setHorzTextAlign("center");
    obj.edit43:setField("testeDesvantagem7");
    obj.edit43:setWidth(64);
    obj.edit43:setMargins({left=6});
    obj.edit43:setName("edit43");

    obj.button18 = GUI.fromHandle(_obj_newObject("button"));
    obj.button18:setParent(obj.layout29);
    obj.button18:setName("button18");
    obj.button18:setWidth(40);
    obj.button18:setText("rolar");
    obj.button18:setCursor("handPoint");
    obj.button18.grid.role = "block";
    obj.button18:setHeight(25);
    obj.button18:setMargins({left=6});

    obj.layout30 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout30:setParent(obj.tab3);
    obj.layout30.grid.role = "block";
    obj.layout30:setHeight(25);
    obj.layout30:setMargins({top=9});
    obj.layout30:setName("layout30");
    obj.layout30:setWidth(450);

    obj.edit44 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit44:setParent(obj.layout30);
    obj.edit44:setAlign("left");
    obj.edit44:setHorzTextAlign("leading");
    obj.edit44:setField("desvantagem8");
    obj.edit44:setWidth(204);
    obj.edit44:setName("edit44");

    obj.edit45 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit45:setParent(obj.layout30);
    obj.edit45:setAlign("left");
    obj.edit45:setHorzTextAlign("center");
    obj.edit45:setField("testeDesvantagem8");
    obj.edit45:setWidth(64);
    obj.edit45:setMargins({left=6});
    obj.edit45:setName("edit45");

    obj.button19 = GUI.fromHandle(_obj_newObject("button"));
    obj.button19:setParent(obj.layout30);
    obj.button19:setName("button19");
    obj.button19:setWidth(40);
    obj.button19:setText("rolar");
    obj.button19:setCursor("handPoint");
    obj.button19.grid.role = "block";
    obj.button19:setHeight(25);
    obj.button19:setMargins({left=6});

    obj.layout31 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout31:setParent(obj.tab1);
    obj.layout31.grid.role = "col";
    obj.layout31.grid.width = 3;
    obj.layout31:setHeight(450);
    obj.layout31:setMargins({top=10});
    obj.layout31:setName("layout31");

    obj.tabControl3 = GUI.fromHandle(_obj_newObject("tabControl"));
    obj.tabControl3:setParent(obj.layout31);
    obj.tabControl3.grid.role = "col";
    obj.tabControl3.grid.width = 12;
    obj.tabControl3:setHeight(450);
    obj.tabControl3:setName("tabControl3");

    obj.tab4 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab4:setParent(obj.tabControl3);
    obj.tab4:setTitle("Aba de capacidades 1");
    obj.tab4:setName("tab4");

    obj.layout32 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout32:setParent(obj.tab4);
    obj.layout32.grid.role = "block";
    obj.layout32:setHeight(25);
    obj.layout32:setWidth(250);
    obj.layout32:setMargins({top=12});
    obj.layout32:setName("layout32");

    obj.label25 = GUI.fromHandle(_obj_newObject("label"));
    obj.label25:setParent(obj.layout32);
    obj.label25:setAlign("left");
    obj.label25:setText("Capacidades");
    obj.label25:setWidth(124);
    obj.label25:setName("label25");

    obj.label26 = GUI.fromHandle(_obj_newObject("label"));
    obj.label26:setParent(obj.layout32);
    obj.label26:setAlign("right");
    obj.label26:setText("Teste");
    obj.label26:setWidth(64);
    obj.label26:setMargins({right=16});
    obj.label26:setName("label26");

    obj.layout33 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout33:setParent(obj.tab4);
    obj.layout33.grid.role = "block";
    obj.layout33:setWidth(250);
    obj.layout33:setHeight(420);
    obj.layout33:setName("layout33");

    obj.layout34 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout34:setParent(obj.layout33);
    obj.layout34.grid.role = "block";
    obj.layout34:setHeight(25);
    obj.layout34:setName("layout34");
    obj.layout34:setWidth(250);
    obj.layout34:setMargins({top=7});

    obj.edit46 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit46:setParent(obj.layout34);
    obj.edit46:setField("capacidade1");
    obj.edit46:setName("edit46");
    obj.edit46:setWidth(164);
    obj.edit46:setAlign("left");
    obj.edit46:setHorzTextAlign("leading");

    obj.edit47 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit47:setParent(obj.layout34);
    obj.edit47:setField("testeCapacidade1");
    obj.edit47:setName("edit47");
    obj.edit47:setWidth(30);
    obj.edit47:setMargins({left=5});
    obj.edit47:setAlign("left");
    obj.edit47:setHorzTextAlign("center");

    obj.button20 = GUI.fromHandle(_obj_newObject("button"));
    obj.button20:setParent(obj.layout34);
    obj.button20:setName("button20");
    obj.button20:setWidth(40);
    obj.button20:setText("rolar");
    obj.button20:setCursor("handPoint");
    obj.button20.grid.role = "block";
    obj.button20:setHeight(25);
    obj.button20:setMargins({left=6});

    obj.layout35 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout35:setParent(obj.layout33);
    obj.layout35.grid.role = "block";
    obj.layout35:setHeight(25);
    obj.layout35:setName("layout35");
    obj.layout35:setWidth(250);
    obj.layout35:setMargins({top=7});

    obj.edit48 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit48:setParent(obj.layout35);
    obj.edit48:setField("capacidade2");
    obj.edit48:setName("edit48");
    obj.edit48:setWidth(164);
    obj.edit48:setAlign("left");
    obj.edit48:setHorzTextAlign("leading");

    obj.edit49 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit49:setParent(obj.layout35);
    obj.edit49:setField("testeCapacidade2");
    obj.edit49:setName("edit49");
    obj.edit49:setWidth(30);
    obj.edit49:setMargins({left=5});
    obj.edit49:setAlign("left");
    obj.edit49:setHorzTextAlign("center");

    obj.button21 = GUI.fromHandle(_obj_newObject("button"));
    obj.button21:setParent(obj.layout35);
    obj.button21:setName("button21");
    obj.button21:setWidth(40);
    obj.button21:setText("rolar");
    obj.button21:setCursor("handPoint");
    obj.button21.grid.role = "block";
    obj.button21:setHeight(25);
    obj.button21:setMargins({left=6});

    obj.layout36 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout36:setParent(obj.layout33);
    obj.layout36.grid.role = "block";
    obj.layout36:setHeight(25);
    obj.layout36:setName("layout36");
    obj.layout36:setWidth(250);
    obj.layout36:setMargins({top=7});

    obj.edit50 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit50:setParent(obj.layout36);
    obj.edit50:setField("capacidade3");
    obj.edit50:setName("edit50");
    obj.edit50:setWidth(164);
    obj.edit50:setAlign("left");
    obj.edit50:setHorzTextAlign("leading");

    obj.edit51 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit51:setParent(obj.layout36);
    obj.edit51:setField("testeCapacidade3");
    obj.edit51:setName("edit51");
    obj.edit51:setWidth(30);
    obj.edit51:setMargins({left=5});
    obj.edit51:setAlign("left");
    obj.edit51:setHorzTextAlign("center");

    obj.button22 = GUI.fromHandle(_obj_newObject("button"));
    obj.button22:setParent(obj.layout36);
    obj.button22:setName("button22");
    obj.button22:setWidth(40);
    obj.button22:setText("rolar");
    obj.button22:setCursor("handPoint");
    obj.button22.grid.role = "block";
    obj.button22:setHeight(25);
    obj.button22:setMargins({left=6});

    obj.layout37 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout37:setParent(obj.layout33);
    obj.layout37.grid.role = "block";
    obj.layout37:setHeight(25);
    obj.layout37:setName("layout37");
    obj.layout37:setWidth(250);
    obj.layout37:setMargins({top=7});

    obj.edit52 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit52:setParent(obj.layout37);
    obj.edit52:setField("capacidade4");
    obj.edit52:setName("edit52");
    obj.edit52:setWidth(164);
    obj.edit52:setAlign("left");
    obj.edit52:setHorzTextAlign("leading");

    obj.edit53 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit53:setParent(obj.layout37);
    obj.edit53:setField("testeCapacidade4");
    obj.edit53:setName("edit53");
    obj.edit53:setWidth(30);
    obj.edit53:setMargins({left=5});
    obj.edit53:setAlign("left");
    obj.edit53:setHorzTextAlign("center");

    obj.button23 = GUI.fromHandle(_obj_newObject("button"));
    obj.button23:setParent(obj.layout37);
    obj.button23:setName("button23");
    obj.button23:setWidth(40);
    obj.button23:setText("rolar");
    obj.button23:setCursor("handPoint");
    obj.button23.grid.role = "block";
    obj.button23:setHeight(25);
    obj.button23:setMargins({left=6});

    obj.layout38 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout38:setParent(obj.layout33);
    obj.layout38.grid.role = "block";
    obj.layout38:setHeight(25);
    obj.layout38:setName("layout38");
    obj.layout38:setWidth(250);
    obj.layout38:setMargins({top=7});

    obj.edit54 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit54:setParent(obj.layout38);
    obj.edit54:setField("capacidade5");
    obj.edit54:setName("edit54");
    obj.edit54:setWidth(164);
    obj.edit54:setAlign("left");
    obj.edit54:setHorzTextAlign("leading");

    obj.edit55 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit55:setParent(obj.layout38);
    obj.edit55:setField("testeCapacidade5");
    obj.edit55:setName("edit55");
    obj.edit55:setWidth(30);
    obj.edit55:setMargins({left=5});
    obj.edit55:setAlign("left");
    obj.edit55:setHorzTextAlign("center");

    obj.button24 = GUI.fromHandle(_obj_newObject("button"));
    obj.button24:setParent(obj.layout38);
    obj.button24:setName("button24");
    obj.button24:setWidth(40);
    obj.button24:setText("rolar");
    obj.button24:setCursor("handPoint");
    obj.button24.grid.role = "block";
    obj.button24:setHeight(25);
    obj.button24:setMargins({left=6});

    obj.layout39 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout39:setParent(obj.layout33);
    obj.layout39.grid.role = "block";
    obj.layout39:setHeight(25);
    obj.layout39:setName("layout39");
    obj.layout39:setWidth(250);
    obj.layout39:setMargins({top=7});

    obj.edit56 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit56:setParent(obj.layout39);
    obj.edit56:setField("capacidade6");
    obj.edit56:setName("edit56");
    obj.edit56:setWidth(164);
    obj.edit56:setAlign("left");
    obj.edit56:setHorzTextAlign("leading");

    obj.edit57 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit57:setParent(obj.layout39);
    obj.edit57:setField("testeCapacidade6");
    obj.edit57:setName("edit57");
    obj.edit57:setWidth(30);
    obj.edit57:setMargins({left=5});
    obj.edit57:setAlign("left");
    obj.edit57:setHorzTextAlign("center");

    obj.button25 = GUI.fromHandle(_obj_newObject("button"));
    obj.button25:setParent(obj.layout39);
    obj.button25:setName("button25");
    obj.button25:setWidth(40);
    obj.button25:setText("rolar");
    obj.button25:setCursor("handPoint");
    obj.button25.grid.role = "block";
    obj.button25:setHeight(25);
    obj.button25:setMargins({left=6});

    obj.layout40 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout40:setParent(obj.layout33);
    obj.layout40.grid.role = "block";
    obj.layout40:setHeight(25);
    obj.layout40:setName("layout40");
    obj.layout40:setWidth(250);
    obj.layout40:setMargins({top=7});

    obj.edit58 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit58:setParent(obj.layout40);
    obj.edit58:setField("capacidade7");
    obj.edit58:setName("edit58");
    obj.edit58:setWidth(164);
    obj.edit58:setAlign("left");
    obj.edit58:setHorzTextAlign("leading");

    obj.edit59 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit59:setParent(obj.layout40);
    obj.edit59:setField("testeCapacidade7");
    obj.edit59:setName("edit59");
    obj.edit59:setWidth(30);
    obj.edit59:setMargins({left=5});
    obj.edit59:setAlign("left");
    obj.edit59:setHorzTextAlign("center");

    obj.button26 = GUI.fromHandle(_obj_newObject("button"));
    obj.button26:setParent(obj.layout40);
    obj.button26:setName("button26");
    obj.button26:setWidth(40);
    obj.button26:setText("rolar");
    obj.button26:setCursor("handPoint");
    obj.button26.grid.role = "block";
    obj.button26:setHeight(25);
    obj.button26:setMargins({left=6});

    obj.layout41 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout41:setParent(obj.layout33);
    obj.layout41.grid.role = "block";
    obj.layout41:setHeight(25);
    obj.layout41:setName("layout41");
    obj.layout41:setWidth(250);
    obj.layout41:setMargins({top=7});

    obj.edit60 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit60:setParent(obj.layout41);
    obj.edit60:setField("capacidade8");
    obj.edit60:setName("edit60");
    obj.edit60:setWidth(164);
    obj.edit60:setAlign("left");
    obj.edit60:setHorzTextAlign("leading");

    obj.edit61 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit61:setParent(obj.layout41);
    obj.edit61:setField("testeCapacidade8");
    obj.edit61:setName("edit61");
    obj.edit61:setWidth(30);
    obj.edit61:setMargins({left=5});
    obj.edit61:setAlign("left");
    obj.edit61:setHorzTextAlign("center");

    obj.button27 = GUI.fromHandle(_obj_newObject("button"));
    obj.button27:setParent(obj.layout41);
    obj.button27:setName("button27");
    obj.button27:setWidth(40);
    obj.button27:setText("rolar");
    obj.button27:setCursor("handPoint");
    obj.button27.grid.role = "block";
    obj.button27:setHeight(25);
    obj.button27:setMargins({left=6});

    obj.layout42 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout42:setParent(obj.layout33);
    obj.layout42.grid.role = "block";
    obj.layout42:setHeight(25);
    obj.layout42:setWidth(250);
    obj.layout42:setMargins({top=4});
    obj.layout42:setName("layout42");

    obj.label27 = GUI.fromHandle(_obj_newObject("label"));
    obj.label27:setParent(obj.layout42);
    obj.label27:setAlign("left");
    obj.label27:setText("Movimentos Aprimorados");
    obj.label27:setName("label27");
    obj.label27:setWidth(164);
    obj.label27:setHorzTextAlign("leading");

    obj.label28 = GUI.fromHandle(_obj_newObject("label"));
    obj.label28:setParent(obj.layout42);
    obj.label28:setAlign("left");
    obj.label28:setText("Teste");
    obj.label28:setWidth(64);
    obj.label28:setMargins({left=6});
    obj.label28:setName("label28");

    obj.layout43 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout43:setParent(obj.layout33);
    obj.layout43.grid.role = "block";
    obj.layout43:setHeight(25);
    obj.layout43:setName("layout43");
    obj.layout43:setWidth(250);
    obj.layout43:setMargins({top=7});

    obj.edit62 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit62:setParent(obj.layout43);
    obj.edit62:setField("moviApri1");
    obj.edit62:setName("edit62");
    obj.edit62:setWidth(164);
    obj.edit62:setAlign("left");
    obj.edit62:setHorzTextAlign("leading");

    obj.edit63 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit63:setParent(obj.layout43);
    obj.edit63:setField("testeMoviApri1");
    obj.edit63:setName("edit63");
    obj.edit63:setWidth(30);
    obj.edit63:setMargins({left=5});
    obj.edit63:setAlign("left");
    obj.edit63:setHorzTextAlign("center");

    obj.button28 = GUI.fromHandle(_obj_newObject("button"));
    obj.button28:setParent(obj.layout43);
    obj.button28:setName("button28");
    obj.button28:setWidth(40);
    obj.button28:setText("rolar");
    obj.button28:setCursor("handPoint");
    obj.button28.grid.role = "block";
    obj.button28:setHeight(25);
    obj.button28:setMargins({left=6});

    obj.layout44 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout44:setParent(obj.layout33);
    obj.layout44.grid.role = "block";
    obj.layout44:setHeight(25);
    obj.layout44:setName("layout44");
    obj.layout44:setWidth(250);
    obj.layout44:setMargins({top=7});

    obj.edit64 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit64:setParent(obj.layout44);
    obj.edit64:setField("moviApri2");
    obj.edit64:setName("edit64");
    obj.edit64:setWidth(164);
    obj.edit64:setAlign("left");
    obj.edit64:setHorzTextAlign("leading");

    obj.edit65 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit65:setParent(obj.layout44);
    obj.edit65:setField("testeMoviApri2");
    obj.edit65:setName("edit65");
    obj.edit65:setWidth(30);
    obj.edit65:setMargins({left=5});
    obj.edit65:setAlign("left");
    obj.edit65:setHorzTextAlign("center");

    obj.button29 = GUI.fromHandle(_obj_newObject("button"));
    obj.button29:setParent(obj.layout44);
    obj.button29:setName("button29");
    obj.button29:setWidth(40);
    obj.button29:setText("rolar");
    obj.button29:setCursor("handPoint");
    obj.button29.grid.role = "block";
    obj.button29:setHeight(25);
    obj.button29:setMargins({left=6});

    obj.layout45 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout45:setParent(obj.layout33);
    obj.layout45.grid.role = "block";
    obj.layout45:setHeight(25);
    obj.layout45:setName("layout45");
    obj.layout45:setWidth(250);
    obj.layout45:setMargins({top=7});

    obj.edit66 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit66:setParent(obj.layout45);
    obj.edit66:setField("moviApri3");
    obj.edit66:setName("edit66");
    obj.edit66:setWidth(164);
    obj.edit66:setAlign("left");
    obj.edit66:setHorzTextAlign("leading");

    obj.edit67 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit67:setParent(obj.layout45);
    obj.edit67:setField("testeMoviApri3");
    obj.edit67:setName("edit67");
    obj.edit67:setWidth(30);
    obj.edit67:setMargins({left=5});
    obj.edit67:setAlign("left");
    obj.edit67:setHorzTextAlign("center");

    obj.button30 = GUI.fromHandle(_obj_newObject("button"));
    obj.button30:setParent(obj.layout45);
    obj.button30:setName("button30");
    obj.button30:setWidth(40);
    obj.button30:setText("rolar");
    obj.button30:setCursor("handPoint");
    obj.button30.grid.role = "block";
    obj.button30:setHeight(25);
    obj.button30:setMargins({left=6});

    obj.tab5 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab5:setParent(obj.tabControl3);
    obj.tab5:setTitle("Aba de capacidades 2");
    obj.tab5:setName("tab5");

    obj.layout46 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout46:setParent(obj.tab5);
    obj.layout46.grid.role = "col";
    obj.layout46.grid.width = 12;
    obj.layout46:setHeight(420);
    obj.layout46:setName("layout46");

    obj.layout47 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout47:setParent(obj.layout46);
    obj.layout47.grid.role = "block";
    obj.layout47:setHeight(25);
    obj.layout47:setWidth(250);
    obj.layout47:setMargins({top=12});
    obj.layout47:setName("layout47");

    obj.label29 = GUI.fromHandle(_obj_newObject("label"));
    obj.label29:setParent(obj.layout47);
    obj.label29:setAlign("left");
    obj.label29:setText("Capacidades");
    obj.label29:setWidth(124);
    obj.label29:setName("label29");

    obj.label30 = GUI.fromHandle(_obj_newObject("label"));
    obj.label30:setParent(obj.layout47);
    obj.label30:setAlign("right");
    obj.label30:setText("Teste");
    obj.label30:setWidth(64);
    obj.label30:setMargins({right=16});
    obj.label30:setName("label30");

    obj.layout48 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout48:setParent(obj.layout46);
    obj.layout48.grid.role = "block";
    obj.layout48:setHeight(25);
    obj.layout48:setName("layout48");
    obj.layout48:setWidth(250);
    obj.layout48:setMargins({top=7});

    obj.edit68 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit68:setParent(obj.layout48);
    obj.edit68:setField("capacidade16");
    obj.edit68:setName("edit68");
    obj.edit68:setWidth(164);
    obj.edit68:setAlign("left");
    obj.edit68:setHorzTextAlign("leading");

    obj.edit69 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit69:setParent(obj.layout48);
    obj.edit69:setField("testeCapacidade16");
    obj.edit69:setName("edit69");
    obj.edit69:setWidth(30);
    obj.edit69:setMargins({left=5});
    obj.edit69:setAlign("left");
    obj.edit69:setHorzTextAlign("center");

    obj.button31 = GUI.fromHandle(_obj_newObject("button"));
    obj.button31:setParent(obj.layout48);
    obj.button31:setName("button31");
    obj.button31:setWidth(40);
    obj.button31:setText("rolar");
    obj.button31:setCursor("handPoint");
    obj.button31.grid.role = "block";
    obj.button31:setHeight(25);
    obj.button31:setMargins({left=6});

    obj.layout49 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout49:setParent(obj.layout46);
    obj.layout49.grid.role = "block";
    obj.layout49:setHeight(25);
    obj.layout49:setName("layout49");
    obj.layout49:setWidth(250);
    obj.layout49:setMargins({top=7});

    obj.edit70 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit70:setParent(obj.layout49);
    obj.edit70:setField("capacidade9");
    obj.edit70:setName("edit70");
    obj.edit70:setWidth(164);
    obj.edit70:setAlign("left");
    obj.edit70:setHorzTextAlign("leading");

    obj.edit71 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit71:setParent(obj.layout49);
    obj.edit71:setField("testeCapacidade9");
    obj.edit71:setName("edit71");
    obj.edit71:setWidth(30);
    obj.edit71:setMargins({left=5});
    obj.edit71:setAlign("left");
    obj.edit71:setHorzTextAlign("center");

    obj.button32 = GUI.fromHandle(_obj_newObject("button"));
    obj.button32:setParent(obj.layout49);
    obj.button32:setName("button32");
    obj.button32:setWidth(40);
    obj.button32:setText("rolar");
    obj.button32:setCursor("handPoint");
    obj.button32.grid.role = "block";
    obj.button32:setHeight(25);
    obj.button32:setMargins({left=6});

    obj.layout50 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout50:setParent(obj.layout46);
    obj.layout50.grid.role = "block";
    obj.layout50:setHeight(25);
    obj.layout50:setName("layout50");
    obj.layout50:setWidth(250);
    obj.layout50:setMargins({top=7});

    obj.edit72 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit72:setParent(obj.layout50);
    obj.edit72:setField("capacidade10");
    obj.edit72:setName("edit72");
    obj.edit72:setWidth(164);
    obj.edit72:setAlign("left");
    obj.edit72:setHorzTextAlign("leading");

    obj.edit73 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit73:setParent(obj.layout50);
    obj.edit73:setField("testeCapacidade10");
    obj.edit73:setName("edit73");
    obj.edit73:setWidth(30);
    obj.edit73:setMargins({left=5});
    obj.edit73:setAlign("left");
    obj.edit73:setHorzTextAlign("center");

    obj.button33 = GUI.fromHandle(_obj_newObject("button"));
    obj.button33:setParent(obj.layout50);
    obj.button33:setName("button33");
    obj.button33:setWidth(40);
    obj.button33:setText("rolar");
    obj.button33:setCursor("handPoint");
    obj.button33.grid.role = "block";
    obj.button33:setHeight(25);
    obj.button33:setMargins({left=6});

    obj.layout51 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout51:setParent(obj.layout46);
    obj.layout51.grid.role = "block";
    obj.layout51:setHeight(25);
    obj.layout51:setName("layout51");
    obj.layout51:setWidth(250);
    obj.layout51:setMargins({top=7});

    obj.edit74 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit74:setParent(obj.layout51);
    obj.edit74:setField("capacidade11");
    obj.edit74:setName("edit74");
    obj.edit74:setWidth(164);
    obj.edit74:setAlign("left");
    obj.edit74:setHorzTextAlign("leading");

    obj.edit75 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit75:setParent(obj.layout51);
    obj.edit75:setField("testeCapacidade11");
    obj.edit75:setName("edit75");
    obj.edit75:setWidth(30);
    obj.edit75:setMargins({left=5});
    obj.edit75:setAlign("left");
    obj.edit75:setHorzTextAlign("center");

    obj.button34 = GUI.fromHandle(_obj_newObject("button"));
    obj.button34:setParent(obj.layout51);
    obj.button34:setName("button34");
    obj.button34:setWidth(40);
    obj.button34:setText("rolar");
    obj.button34:setCursor("handPoint");
    obj.button34.grid.role = "block";
    obj.button34:setHeight(25);
    obj.button34:setMargins({left=6});

    obj.layout52 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout52:setParent(obj.layout46);
    obj.layout52.grid.role = "block";
    obj.layout52:setHeight(25);
    obj.layout52:setName("layout52");
    obj.layout52:setWidth(250);
    obj.layout52:setMargins({top=7});

    obj.edit76 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit76:setParent(obj.layout52);
    obj.edit76:setField("capacidade12");
    obj.edit76:setName("edit76");
    obj.edit76:setWidth(164);
    obj.edit76:setAlign("left");
    obj.edit76:setHorzTextAlign("leading");

    obj.edit77 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit77:setParent(obj.layout52);
    obj.edit77:setField("testeCapacidade12");
    obj.edit77:setName("edit77");
    obj.edit77:setWidth(30);
    obj.edit77:setMargins({left=5});
    obj.edit77:setAlign("left");
    obj.edit77:setHorzTextAlign("center");

    obj.button35 = GUI.fromHandle(_obj_newObject("button"));
    obj.button35:setParent(obj.layout52);
    obj.button35:setName("button35");
    obj.button35:setWidth(40);
    obj.button35:setText("rolar");
    obj.button35:setCursor("handPoint");
    obj.button35.grid.role = "block";
    obj.button35:setHeight(25);
    obj.button35:setMargins({left=6});

    obj.layout53 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout53:setParent(obj.layout46);
    obj.layout53.grid.role = "block";
    obj.layout53:setHeight(25);
    obj.layout53:setName("layout53");
    obj.layout53:setWidth(250);
    obj.layout53:setMargins({top=7});

    obj.edit78 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit78:setParent(obj.layout53);
    obj.edit78:setField("capacidade13");
    obj.edit78:setName("edit78");
    obj.edit78:setWidth(164);
    obj.edit78:setAlign("left");
    obj.edit78:setHorzTextAlign("leading");

    obj.edit79 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit79:setParent(obj.layout53);
    obj.edit79:setField("testeCapacidade13");
    obj.edit79:setName("edit79");
    obj.edit79:setWidth(30);
    obj.edit79:setMargins({left=5});
    obj.edit79:setAlign("left");
    obj.edit79:setHorzTextAlign("center");

    obj.button36 = GUI.fromHandle(_obj_newObject("button"));
    obj.button36:setParent(obj.layout53);
    obj.button36:setName("button36");
    obj.button36:setWidth(40);
    obj.button36:setText("rolar");
    obj.button36:setCursor("handPoint");
    obj.button36.grid.role = "block";
    obj.button36:setHeight(25);
    obj.button36:setMargins({left=6});

    obj.layout54 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout54:setParent(obj.layout46);
    obj.layout54.grid.role = "block";
    obj.layout54:setHeight(25);
    obj.layout54:setName("layout54");
    obj.layout54:setWidth(250);
    obj.layout54:setMargins({top=7});

    obj.edit80 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit80:setParent(obj.layout54);
    obj.edit80:setField("capacidade14");
    obj.edit80:setName("edit80");
    obj.edit80:setWidth(164);
    obj.edit80:setAlign("left");
    obj.edit80:setHorzTextAlign("leading");

    obj.edit81 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit81:setParent(obj.layout54);
    obj.edit81:setField("testeCapacidade14");
    obj.edit81:setName("edit81");
    obj.edit81:setWidth(30);
    obj.edit81:setMargins({left=5});
    obj.edit81:setAlign("left");
    obj.edit81:setHorzTextAlign("center");

    obj.button37 = GUI.fromHandle(_obj_newObject("button"));
    obj.button37:setParent(obj.layout54);
    obj.button37:setName("button37");
    obj.button37:setWidth(40);
    obj.button37:setText("rolar");
    obj.button37:setCursor("handPoint");
    obj.button37.grid.role = "block";
    obj.button37:setHeight(25);
    obj.button37:setMargins({left=6});

    obj.layout55 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout55:setParent(obj.layout46);
    obj.layout55.grid.role = "block";
    obj.layout55:setHeight(25);
    obj.layout55:setName("layout55");
    obj.layout55:setWidth(250);
    obj.layout55:setMargins({top=7});

    obj.edit82 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit82:setParent(obj.layout55);
    obj.edit82:setField("capacidade15");
    obj.edit82:setName("edit82");
    obj.edit82:setWidth(164);
    obj.edit82:setAlign("left");
    obj.edit82:setHorzTextAlign("leading");

    obj.edit83 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit83:setParent(obj.layout55);
    obj.edit83:setField("testeCapacidade15");
    obj.edit83:setName("edit83");
    obj.edit83:setWidth(30);
    obj.edit83:setMargins({left=5});
    obj.edit83:setAlign("left");
    obj.edit83:setHorzTextAlign("center");

    obj.button38 = GUI.fromHandle(_obj_newObject("button"));
    obj.button38:setParent(obj.layout55);
    obj.button38:setName("button38");
    obj.button38:setWidth(40);
    obj.button38:setText("rolar");
    obj.button38:setCursor("handPoint");
    obj.button38.grid.role = "block";
    obj.button38:setHeight(25);
    obj.button38:setMargins({left=6});

    obj.layout56 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout56:setParent(obj.layout46);
    obj.layout56.grid.role = "block";
    obj.layout56:setHeight(25);
    obj.layout56:setWidth(250);
    obj.layout56:setMargins({top=4});
    obj.layout56:setName("layout56");

    obj.label31 = GUI.fromHandle(_obj_newObject("label"));
    obj.label31:setParent(obj.layout56);
    obj.label31:setAlign("left");
    obj.label31:setText("Movimentos Aprimorados");
    obj.label31:setName("label31");
    obj.label31:setWidth(164);
    obj.label31:setHorzTextAlign("leading");

    obj.label32 = GUI.fromHandle(_obj_newObject("label"));
    obj.label32:setParent(obj.layout56);
    obj.label32:setAlign("left");
    obj.label32:setText("Teste");
    obj.label32:setWidth(64);
    obj.label32:setMargins({left=6});
    obj.label32:setName("label32");

    obj.layout57 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout57:setParent(obj.layout46);
    obj.layout57.grid.role = "block";
    obj.layout57:setHeight(25);
    obj.layout57:setName("layout57");
    obj.layout57:setWidth(250);
    obj.layout57:setMargins({top=7});

    obj.edit84 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit84:setParent(obj.layout57);
    obj.edit84:setField("moviApri4");
    obj.edit84:setName("edit84");
    obj.edit84:setWidth(164);
    obj.edit84:setAlign("left");
    obj.edit84:setHorzTextAlign("leading");

    obj.edit85 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit85:setParent(obj.layout57);
    obj.edit85:setField("testeMoviApri4");
    obj.edit85:setName("edit85");
    obj.edit85:setWidth(30);
    obj.edit85:setMargins({left=5});
    obj.edit85:setAlign("left");
    obj.edit85:setHorzTextAlign("center");

    obj.button39 = GUI.fromHandle(_obj_newObject("button"));
    obj.button39:setParent(obj.layout57);
    obj.button39:setName("button39");
    obj.button39:setWidth(40);
    obj.button39:setText("rolar");
    obj.button39:setCursor("handPoint");
    obj.button39.grid.role = "block";
    obj.button39:setHeight(25);
    obj.button39:setMargins({left=6});

    obj.layout58 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout58:setParent(obj.layout46);
    obj.layout58.grid.role = "block";
    obj.layout58:setHeight(25);
    obj.layout58:setName("layout58");
    obj.layout58:setWidth(250);
    obj.layout58:setMargins({top=7});

    obj.edit86 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit86:setParent(obj.layout58);
    obj.edit86:setField("moviApri5");
    obj.edit86:setName("edit86");
    obj.edit86:setWidth(164);
    obj.edit86:setAlign("left");
    obj.edit86:setHorzTextAlign("leading");

    obj.edit87 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit87:setParent(obj.layout58);
    obj.edit87:setField("testeMoviApri5");
    obj.edit87:setName("edit87");
    obj.edit87:setWidth(30);
    obj.edit87:setMargins({left=5});
    obj.edit87:setAlign("left");
    obj.edit87:setHorzTextAlign("center");

    obj.button40 = GUI.fromHandle(_obj_newObject("button"));
    obj.button40:setParent(obj.layout58);
    obj.button40:setName("button40");
    obj.button40:setWidth(40);
    obj.button40:setText("rolar");
    obj.button40:setCursor("handPoint");
    obj.button40.grid.role = "block";
    obj.button40:setHeight(25);
    obj.button40:setMargins({left=6});

    obj.layout59 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout59:setParent(obj.layout46);
    obj.layout59.grid.role = "block";
    obj.layout59:setHeight(25);
    obj.layout59:setName("layout59");
    obj.layout59:setWidth(250);
    obj.layout59:setMargins({top=7});

    obj.edit88 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit88:setParent(obj.layout59);
    obj.edit88:setField("moviApri6");
    obj.edit88:setName("edit88");
    obj.edit88:setWidth(164);
    obj.edit88:setAlign("left");
    obj.edit88:setHorzTextAlign("leading");

    obj.edit89 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit89:setParent(obj.layout59);
    obj.edit89:setField("testeMoviApri6");
    obj.edit89:setName("edit89");
    obj.edit89:setWidth(30);
    obj.edit89:setMargins({left=5});
    obj.edit89:setAlign("left");
    obj.edit89:setHorzTextAlign("center");

    obj.button41 = GUI.fromHandle(_obj_newObject("button"));
    obj.button41:setParent(obj.layout59);
    obj.button41:setName("button41");
    obj.button41:setWidth(40);
    obj.button41:setText("rolar");
    obj.button41:setCursor("handPoint");
    obj.button41.grid.role = "block";
    obj.button41:setHeight(25);
    obj.button41:setMargins({left=6});

    obj.layout60 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout60:setParent(obj.tab1);
    obj.layout60.grid.role = "col";
    obj.layout60.grid.width = 3;
    obj.layout60:setHeight(420);
    obj.layout60:setMargins({top=10});
    obj.layout60:setName("layout60");

    obj.tabControl4 = GUI.fromHandle(_obj_newObject("tabControl"));
    obj.tabControl4:setParent(obj.layout60);
    obj.tabControl4.grid.role = "col";
    obj.tabControl4.grid.width = 12;
    obj.tabControl4:setHeight(320);
    obj.tabControl4:setName("tabControl4");

    obj.tab6 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab6:setParent(obj.tabControl4);
    obj.tab6:setTitle("Aba de perícias 1");
    obj.tab6:setName("tab6");

    obj.layout61 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout61:setParent(obj.tab6);
    obj.layout61.grid.role = "block";
    obj.layout61:setHeight(25);
    obj.layout61:setName("layout61");
    obj.layout61:setWidth(450);

    obj.label33 = GUI.fromHandle(_obj_newObject("label"));
    obj.label33:setParent(obj.layout61);
    obj.label33:setAlign("left");
    obj.label33:setText("Perícias");
    obj.label33:setWidth(124);
    obj.label33:setName("label33");

    obj.label34 = GUI.fromHandle(_obj_newObject("label"));
    obj.label34:setParent(obj.layout61);
    obj.label34:setAlign("left");
    obj.label34:setText("Teste");
    obj.label34:setWidth(64);
    obj.label34:setMargins({left=45});
    obj.label34:setName("label34");

    obj.layout62 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout62:setParent(obj.tab6);
    obj.layout62.grid.role = "block";
    obj.layout62:setHeight(25);
    obj.layout62:setName("layout62");
    obj.layout62:setWidth(250);
    obj.layout62:setMargins({top=7});

    obj.edit90 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit90:setParent(obj.layout62);
    obj.edit90:setField("Pericia1");
    obj.edit90:setName("edit90");
    obj.edit90:setWidth(164);
    obj.edit90:setAlign("left");
    obj.edit90:setHorzTextAlign("leading");

    obj.edit91 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit91:setParent(obj.layout62);
    obj.edit91:setField("testePericia1");
    obj.edit91:setName("edit91");
    obj.edit91:setWidth(30);
    obj.edit91:setMargins({left=5});
    obj.edit91:setAlign("left");
    obj.edit91:setHorzTextAlign("center");

    obj.button42 = GUI.fromHandle(_obj_newObject("button"));
    obj.button42:setParent(obj.layout62);
    obj.button42:setName("button42");
    obj.button42:setWidth(40);
    obj.button42:setText("rolar");
    obj.button42:setCursor("handPoint");
    obj.button42.grid.role = "block";
    obj.button42:setHeight(25);
    obj.button42:setMargins({left=6});

    obj.layout63 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout63:setParent(obj.tab6);
    obj.layout63.grid.role = "block";
    obj.layout63:setHeight(25);
    obj.layout63:setName("layout63");
    obj.layout63:setWidth(250);
    obj.layout63:setMargins({top=7});

    obj.edit92 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit92:setParent(obj.layout63);
    obj.edit92:setField("Pericia2");
    obj.edit92:setName("edit92");
    obj.edit92:setWidth(164);
    obj.edit92:setAlign("left");
    obj.edit92:setHorzTextAlign("leading");

    obj.edit93 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit93:setParent(obj.layout63);
    obj.edit93:setField("testePericia2");
    obj.edit93:setName("edit93");
    obj.edit93:setWidth(30);
    obj.edit93:setMargins({left=5});
    obj.edit93:setAlign("left");
    obj.edit93:setHorzTextAlign("center");

    obj.button43 = GUI.fromHandle(_obj_newObject("button"));
    obj.button43:setParent(obj.layout63);
    obj.button43:setName("button43");
    obj.button43:setWidth(40);
    obj.button43:setText("rolar");
    obj.button43:setCursor("handPoint");
    obj.button43.grid.role = "block";
    obj.button43:setHeight(25);
    obj.button43:setMargins({left=6});

    obj.layout64 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout64:setParent(obj.tab6);
    obj.layout64.grid.role = "block";
    obj.layout64:setHeight(25);
    obj.layout64:setName("layout64");
    obj.layout64:setWidth(250);
    obj.layout64:setMargins({top=7});

    obj.edit94 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit94:setParent(obj.layout64);
    obj.edit94:setField("Pericia3");
    obj.edit94:setName("edit94");
    obj.edit94:setWidth(164);
    obj.edit94:setAlign("left");
    obj.edit94:setHorzTextAlign("leading");

    obj.edit95 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit95:setParent(obj.layout64);
    obj.edit95:setField("testePericia3");
    obj.edit95:setName("edit95");
    obj.edit95:setWidth(30);
    obj.edit95:setMargins({left=5});
    obj.edit95:setAlign("left");
    obj.edit95:setHorzTextAlign("center");

    obj.button44 = GUI.fromHandle(_obj_newObject("button"));
    obj.button44:setParent(obj.layout64);
    obj.button44:setName("button44");
    obj.button44:setWidth(40);
    obj.button44:setText("rolar");
    obj.button44:setCursor("handPoint");
    obj.button44.grid.role = "block";
    obj.button44:setHeight(25);
    obj.button44:setMargins({left=6});

    obj.layout65 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout65:setParent(obj.tab6);
    obj.layout65.grid.role = "block";
    obj.layout65:setHeight(25);
    obj.layout65:setName("layout65");
    obj.layout65:setWidth(250);
    obj.layout65:setMargins({top=7});

    obj.edit96 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit96:setParent(obj.layout65);
    obj.edit96:setField("Pericia4");
    obj.edit96:setName("edit96");
    obj.edit96:setWidth(164);
    obj.edit96:setAlign("left");
    obj.edit96:setHorzTextAlign("leading");

    obj.edit97 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit97:setParent(obj.layout65);
    obj.edit97:setField("testePericia4");
    obj.edit97:setName("edit97");
    obj.edit97:setWidth(30);
    obj.edit97:setMargins({left=5});
    obj.edit97:setAlign("left");
    obj.edit97:setHorzTextAlign("center");

    obj.button45 = GUI.fromHandle(_obj_newObject("button"));
    obj.button45:setParent(obj.layout65);
    obj.button45:setName("button45");
    obj.button45:setWidth(40);
    obj.button45:setText("rolar");
    obj.button45:setCursor("handPoint");
    obj.button45.grid.role = "block";
    obj.button45:setHeight(25);
    obj.button45:setMargins({left=6});

    obj.layout66 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout66:setParent(obj.tab6);
    obj.layout66.grid.role = "block";
    obj.layout66:setHeight(25);
    obj.layout66:setName("layout66");
    obj.layout66:setWidth(250);
    obj.layout66:setMargins({top=7});

    obj.edit98 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit98:setParent(obj.layout66);
    obj.edit98:setField("Pericia5");
    obj.edit98:setName("edit98");
    obj.edit98:setWidth(164);
    obj.edit98:setAlign("left");
    obj.edit98:setHorzTextAlign("leading");

    obj.edit99 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit99:setParent(obj.layout66);
    obj.edit99:setField("testePericia5");
    obj.edit99:setName("edit99");
    obj.edit99:setWidth(30);
    obj.edit99:setMargins({left=5});
    obj.edit99:setAlign("left");
    obj.edit99:setHorzTextAlign("center");

    obj.button46 = GUI.fromHandle(_obj_newObject("button"));
    obj.button46:setParent(obj.layout66);
    obj.button46:setName("button46");
    obj.button46:setWidth(40);
    obj.button46:setText("rolar");
    obj.button46:setCursor("handPoint");
    obj.button46.grid.role = "block";
    obj.button46:setHeight(25);
    obj.button46:setMargins({left=6});

    obj.layout67 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout67:setParent(obj.tab6);
    obj.layout67.grid.role = "block";
    obj.layout67:setHeight(25);
    obj.layout67:setName("layout67");
    obj.layout67:setWidth(250);
    obj.layout67:setMargins({top=7});

    obj.edit100 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit100:setParent(obj.layout67);
    obj.edit100:setField("Pericia6");
    obj.edit100:setName("edit100");
    obj.edit100:setWidth(164);
    obj.edit100:setAlign("left");
    obj.edit100:setHorzTextAlign("leading");

    obj.edit101 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit101:setParent(obj.layout67);
    obj.edit101:setField("testePericia6");
    obj.edit101:setName("edit101");
    obj.edit101:setWidth(30);
    obj.edit101:setMargins({left=5});
    obj.edit101:setAlign("left");
    obj.edit101:setHorzTextAlign("center");

    obj.button47 = GUI.fromHandle(_obj_newObject("button"));
    obj.button47:setParent(obj.layout67);
    obj.button47:setName("button47");
    obj.button47:setWidth(40);
    obj.button47:setText("rolar");
    obj.button47:setCursor("handPoint");
    obj.button47.grid.role = "block";
    obj.button47:setHeight(25);
    obj.button47:setMargins({left=6});

    obj.layout68 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout68:setParent(obj.tab6);
    obj.layout68.grid.role = "block";
    obj.layout68:setHeight(25);
    obj.layout68:setName("layout68");
    obj.layout68:setWidth(250);
    obj.layout68:setMargins({top=7});

    obj.edit102 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit102:setParent(obj.layout68);
    obj.edit102:setField("Pericia7");
    obj.edit102:setName("edit102");
    obj.edit102:setWidth(164);
    obj.edit102:setAlign("left");
    obj.edit102:setHorzTextAlign("leading");

    obj.edit103 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit103:setParent(obj.layout68);
    obj.edit103:setField("testePericia7");
    obj.edit103:setName("edit103");
    obj.edit103:setWidth(30);
    obj.edit103:setMargins({left=5});
    obj.edit103:setAlign("left");
    obj.edit103:setHorzTextAlign("center");

    obj.button48 = GUI.fromHandle(_obj_newObject("button"));
    obj.button48:setParent(obj.layout68);
    obj.button48:setName("button48");
    obj.button48:setWidth(40);
    obj.button48:setText("rolar");
    obj.button48:setCursor("handPoint");
    obj.button48.grid.role = "block";
    obj.button48:setHeight(25);
    obj.button48:setMargins({left=6});

    obj.layout69 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout69:setParent(obj.tab6);
    obj.layout69.grid.role = "block";
    obj.layout69:setHeight(25);
    obj.layout69:setName("layout69");
    obj.layout69:setWidth(250);
    obj.layout69:setMargins({top=7});

    obj.edit104 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit104:setParent(obj.layout69);
    obj.edit104:setField("Pericia8");
    obj.edit104:setName("edit104");
    obj.edit104:setWidth(164);
    obj.edit104:setAlign("left");
    obj.edit104:setHorzTextAlign("leading");

    obj.edit105 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit105:setParent(obj.layout69);
    obj.edit105:setField("testePericia8");
    obj.edit105:setName("edit105");
    obj.edit105:setWidth(30);
    obj.edit105:setMargins({left=5});
    obj.edit105:setAlign("left");
    obj.edit105:setHorzTextAlign("center");

    obj.button49 = GUI.fromHandle(_obj_newObject("button"));
    obj.button49:setParent(obj.layout69);
    obj.button49:setName("button49");
    obj.button49:setWidth(40);
    obj.button49:setText("rolar");
    obj.button49:setCursor("handPoint");
    obj.button49.grid.role = "block";
    obj.button49:setHeight(25);
    obj.button49:setMargins({left=6});

    obj.tab7 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab7:setParent(obj.tabControl4);
    obj.tab7:setTitle("Aba de perícias 2");
    obj.tab7:setName("tab7");

    obj.layout70 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout70:setParent(obj.tab7);
    obj.layout70.grid.role = "block";
    obj.layout70:setHeight(25);
    obj.layout70:setName("layout70");
    obj.layout70:setWidth(450);

    obj.label35 = GUI.fromHandle(_obj_newObject("label"));
    obj.label35:setParent(obj.layout70);
    obj.label35:setAlign("left");
    obj.label35:setText("Perícias");
    obj.label35:setWidth(124);
    obj.label35:setName("label35");

    obj.label36 = GUI.fromHandle(_obj_newObject("label"));
    obj.label36:setParent(obj.layout70);
    obj.label36:setAlign("left");
    obj.label36:setText("Teste");
    obj.label36:setWidth(64);
    obj.label36:setMargins({left=45});
    obj.label36:setName("label36");

    obj.layout71 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout71:setParent(obj.tab7);
    obj.layout71.grid.role = "block";
    obj.layout71:setHeight(25);
    obj.layout71:setName("layout71");
    obj.layout71:setWidth(250);
    obj.layout71:setMargins({top=7});

    obj.edit106 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit106:setParent(obj.layout71);
    obj.edit106:setField("Pericia9");
    obj.edit106:setName("edit106");
    obj.edit106:setWidth(164);
    obj.edit106:setAlign("left");
    obj.edit106:setHorzTextAlign("leading");

    obj.edit107 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit107:setParent(obj.layout71);
    obj.edit107:setField("testePericia9");
    obj.edit107:setName("edit107");
    obj.edit107:setWidth(30);
    obj.edit107:setMargins({left=5});
    obj.edit107:setAlign("left");
    obj.edit107:setHorzTextAlign("center");

    obj.button50 = GUI.fromHandle(_obj_newObject("button"));
    obj.button50:setParent(obj.layout71);
    obj.button50:setName("button50");
    obj.button50:setWidth(40);
    obj.button50:setText("rolar");
    obj.button50:setCursor("handPoint");
    obj.button50.grid.role = "block";
    obj.button50:setHeight(25);
    obj.button50:setMargins({left=6});

    obj.layout72 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout72:setParent(obj.tab7);
    obj.layout72.grid.role = "block";
    obj.layout72:setHeight(25);
    obj.layout72:setName("layout72");
    obj.layout72:setWidth(250);
    obj.layout72:setMargins({top=7});

    obj.edit108 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit108:setParent(obj.layout72);
    obj.edit108:setField("Pericia10");
    obj.edit108:setName("edit108");
    obj.edit108:setWidth(164);
    obj.edit108:setAlign("left");
    obj.edit108:setHorzTextAlign("leading");

    obj.edit109 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit109:setParent(obj.layout72);
    obj.edit109:setField("testePericia10");
    obj.edit109:setName("edit109");
    obj.edit109:setWidth(30);
    obj.edit109:setMargins({left=5});
    obj.edit109:setAlign("left");
    obj.edit109:setHorzTextAlign("center");

    obj.button51 = GUI.fromHandle(_obj_newObject("button"));
    obj.button51:setParent(obj.layout72);
    obj.button51:setName("button51");
    obj.button51:setWidth(40);
    obj.button51:setText("rolar");
    obj.button51:setCursor("handPoint");
    obj.button51.grid.role = "block";
    obj.button51:setHeight(25);
    obj.button51:setMargins({left=6});

    obj.layout73 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout73:setParent(obj.tab7);
    obj.layout73.grid.role = "block";
    obj.layout73:setHeight(25);
    obj.layout73:setName("layout73");
    obj.layout73:setWidth(250);
    obj.layout73:setMargins({top=7});

    obj.edit110 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit110:setParent(obj.layout73);
    obj.edit110:setField("Pericia11");
    obj.edit110:setName("edit110");
    obj.edit110:setWidth(164);
    obj.edit110:setAlign("left");
    obj.edit110:setHorzTextAlign("leading");

    obj.edit111 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit111:setParent(obj.layout73);
    obj.edit111:setField("testePericia11");
    obj.edit111:setName("edit111");
    obj.edit111:setWidth(30);
    obj.edit111:setMargins({left=5});
    obj.edit111:setAlign("left");
    obj.edit111:setHorzTextAlign("center");

    obj.button52 = GUI.fromHandle(_obj_newObject("button"));
    obj.button52:setParent(obj.layout73);
    obj.button52:setName("button52");
    obj.button52:setWidth(40);
    obj.button52:setText("rolar");
    obj.button52:setCursor("handPoint");
    obj.button52.grid.role = "block";
    obj.button52:setHeight(25);
    obj.button52:setMargins({left=6});

    obj.layout74 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout74:setParent(obj.tab7);
    obj.layout74.grid.role = "block";
    obj.layout74:setHeight(25);
    obj.layout74:setName("layout74");
    obj.layout74:setWidth(250);
    obj.layout74:setMargins({top=7});

    obj.edit112 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit112:setParent(obj.layout74);
    obj.edit112:setField("Pericia12");
    obj.edit112:setName("edit112");
    obj.edit112:setWidth(164);
    obj.edit112:setAlign("left");
    obj.edit112:setHorzTextAlign("leading");

    obj.edit113 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit113:setParent(obj.layout74);
    obj.edit113:setField("testePericia12");
    obj.edit113:setName("edit113");
    obj.edit113:setWidth(30);
    obj.edit113:setMargins({left=5});
    obj.edit113:setAlign("left");
    obj.edit113:setHorzTextAlign("center");

    obj.button53 = GUI.fromHandle(_obj_newObject("button"));
    obj.button53:setParent(obj.layout74);
    obj.button53:setName("button53");
    obj.button53:setWidth(40);
    obj.button53:setText("rolar");
    obj.button53:setCursor("handPoint");
    obj.button53.grid.role = "block";
    obj.button53:setHeight(25);
    obj.button53:setMargins({left=6});

    obj.layout75 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout75:setParent(obj.tab7);
    obj.layout75.grid.role = "block";
    obj.layout75:setHeight(25);
    obj.layout75:setName("layout75");
    obj.layout75:setWidth(250);
    obj.layout75:setMargins({top=7});

    obj.edit114 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit114:setParent(obj.layout75);
    obj.edit114:setField("Pericia13");
    obj.edit114:setName("edit114");
    obj.edit114:setWidth(164);
    obj.edit114:setAlign("left");
    obj.edit114:setHorzTextAlign("leading");

    obj.edit115 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit115:setParent(obj.layout75);
    obj.edit115:setField("testePericia13");
    obj.edit115:setName("edit115");
    obj.edit115:setWidth(30);
    obj.edit115:setMargins({left=5});
    obj.edit115:setAlign("left");
    obj.edit115:setHorzTextAlign("center");

    obj.button54 = GUI.fromHandle(_obj_newObject("button"));
    obj.button54:setParent(obj.layout75);
    obj.button54:setName("button54");
    obj.button54:setWidth(40);
    obj.button54:setText("rolar");
    obj.button54:setCursor("handPoint");
    obj.button54.grid.role = "block";
    obj.button54:setHeight(25);
    obj.button54:setMargins({left=6});

    obj.layout76 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout76:setParent(obj.tab7);
    obj.layout76.grid.role = "block";
    obj.layout76:setHeight(25);
    obj.layout76:setName("layout76");
    obj.layout76:setWidth(250);
    obj.layout76:setMargins({top=7});

    obj.edit116 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit116:setParent(obj.layout76);
    obj.edit116:setField("Pericia14");
    obj.edit116:setName("edit116");
    obj.edit116:setWidth(164);
    obj.edit116:setAlign("left");
    obj.edit116:setHorzTextAlign("leading");

    obj.edit117 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit117:setParent(obj.layout76);
    obj.edit117:setField("testePericia14");
    obj.edit117:setName("edit117");
    obj.edit117:setWidth(30);
    obj.edit117:setMargins({left=5});
    obj.edit117:setAlign("left");
    obj.edit117:setHorzTextAlign("center");

    obj.button55 = GUI.fromHandle(_obj_newObject("button"));
    obj.button55:setParent(obj.layout76);
    obj.button55:setName("button55");
    obj.button55:setWidth(40);
    obj.button55:setText("rolar");
    obj.button55:setCursor("handPoint");
    obj.button55.grid.role = "block";
    obj.button55:setHeight(25);
    obj.button55:setMargins({left=6});

    obj.layout77 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout77:setParent(obj.tab7);
    obj.layout77.grid.role = "block";
    obj.layout77:setHeight(25);
    obj.layout77:setName("layout77");
    obj.layout77:setWidth(250);
    obj.layout77:setMargins({top=7});

    obj.edit118 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit118:setParent(obj.layout77);
    obj.edit118:setField("Pericia15");
    obj.edit118:setName("edit118");
    obj.edit118:setWidth(164);
    obj.edit118:setAlign("left");
    obj.edit118:setHorzTextAlign("leading");

    obj.edit119 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit119:setParent(obj.layout77);
    obj.edit119:setField("testePericia15");
    obj.edit119:setName("edit119");
    obj.edit119:setWidth(30);
    obj.edit119:setMargins({left=5});
    obj.edit119:setAlign("left");
    obj.edit119:setHorzTextAlign("center");

    obj.button56 = GUI.fromHandle(_obj_newObject("button"));
    obj.button56:setParent(obj.layout77);
    obj.button56:setName("button56");
    obj.button56:setWidth(40);
    obj.button56:setText("rolar");
    obj.button56:setCursor("handPoint");
    obj.button56.grid.role = "block";
    obj.button56:setHeight(25);
    obj.button56:setMargins({left=6});

    obj.layout78 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout78:setParent(obj.tab7);
    obj.layout78.grid.role = "block";
    obj.layout78:setHeight(25);
    obj.layout78:setName("layout78");
    obj.layout78:setWidth(250);
    obj.layout78:setMargins({top=7});

    obj.edit120 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit120:setParent(obj.layout78);
    obj.edit120:setField("Pericia16");
    obj.edit120:setName("edit120");
    obj.edit120:setWidth(164);
    obj.edit120:setAlign("left");
    obj.edit120:setHorzTextAlign("leading");

    obj.edit121 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit121:setParent(obj.layout78);
    obj.edit121:setField("testePericia16");
    obj.edit121:setName("edit121");
    obj.edit121:setWidth(30);
    obj.edit121:setMargins({left=5});
    obj.edit121:setAlign("left");
    obj.edit121:setHorzTextAlign("center");

    obj.button57 = GUI.fromHandle(_obj_newObject("button"));
    obj.button57:setParent(obj.layout78);
    obj.button57:setName("button57");
    obj.button57:setWidth(40);
    obj.button57:setText("rolar");
    obj.button57:setCursor("handPoint");
    obj.button57.grid.role = "block";
    obj.button57:setHeight(25);
    obj.button57:setMargins({left=6});

    obj.layout79 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout79:setParent(obj.layout60);
    obj.layout79.grid.role = "block";
    obj.layout79:setHeight(25);
    obj.layout79:setMargins({top=32});
    obj.layout79:setName("layout79");
    obj.layout79:setWidth(450);

    obj.label37 = GUI.fromHandle(_obj_newObject("label"));
    obj.label37:setParent(obj.layout79);
    obj.label37:setAlign("left");
    obj.label37:setText("PC");
    obj.label37:setWidth(24);
    obj.label37:setName("label37");

    obj.edit122 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit122:setParent(obj.layout79);
    obj.edit122:setAlign("left");
    obj.edit122:setHorzTextAlign("leading");
    obj.edit122:setField("PC");
    obj.edit122:setWidth(64);
    obj.edit122:setName("edit122");

    obj.label38 = GUI.fromHandle(_obj_newObject("label"));
    obj.label38:setParent(obj.layout79);
    obj.label38:setAlign("left");
    obj.label38:setText("PP");
    obj.label38:setWidth(24);
    obj.label38:setMargins({left=6});
    obj.label38:setName("label38");

    obj.edit123 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit123:setParent(obj.layout79);
    obj.edit123:setAlign("left");
    obj.edit123:setHorzTextAlign("leading");
    obj.edit123:setField("PP");
    obj.edit123:setWidth(64);
    obj.edit123:setName("edit123");

    obj.image1 = GUI.fromHandle(_obj_newObject("image"));
    obj.image1:setParent(obj.layout60);
    obj.image1:setLeft(164);
    obj.image1:setTop(295);
    obj.image1:setWidth(125);
    obj.image1:setHeight(125);
    obj.image1:setSRC("/images/bau_ouro.png");
    obj.image1:setName("image1");

    obj.layout80 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout80:setParent(obj.layout60);
    obj.layout80.grid.role = "block";
    obj.layout80:setHeight(25);
    obj.layout80:setMargins({top=10});
    obj.layout80:setName("layout80");
    obj.layout80:setWidth(450);

    obj.label39 = GUI.fromHandle(_obj_newObject("label"));
    obj.label39:setParent(obj.layout80);
    obj.label39:setAlign("left");
    obj.label39:setText("PO");
    obj.label39:setWidth(24);
    obj.label39:setName("label39");

    obj.edit124 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit124:setParent(obj.layout80);
    obj.edit124:setAlign("left");
    obj.edit124:setHorzTextAlign("leading");
    obj.edit124:setField("PO");
    obj.edit124:setWidth(64);
    obj.edit124:setName("edit124");

    obj.label40 = GUI.fromHandle(_obj_newObject("label"));
    obj.label40:setParent(obj.layout80);
    obj.label40:setAlign("left");
    obj.label40:setText("PL");
    obj.label40:setWidth(24);
    obj.label40:setMargins({left=6});
    obj.label40:setName("label40");

    obj.edit125 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit125:setParent(obj.layout80);
    obj.edit125:setAlign("left");
    obj.edit125:setHorzTextAlign("leading");
    obj.edit125:setField("PL");
    obj.edit125:setWidth(64);
    obj.edit125:setName("edit125");

    obj.layout81 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout81:setParent(obj.layout60);
    obj.layout81.grid.role = "block";
    obj.layout81:setHeight(25);
    obj.layout81:setMargins({top=10});
    obj.layout81:setName("layout81");
    obj.layout81:setWidth(450);

    obj.label41 = GUI.fromHandle(_obj_newObject("label"));
    obj.label41:setParent(obj.layout81);
    obj.label41:setAlign("left");
    obj.label41:setText("DA");
    obj.label41:setWidth(24);
    obj.label41:setName("label41");

    obj.edit126 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit126:setParent(obj.layout81);
    obj.edit126:setAlign("left");
    obj.edit126:setHorzTextAlign("leading");
    obj.edit126:setField("DA");
    obj.edit126:setWidth(64);
    obj.edit126:setName("edit126");

    obj.tab8 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab8:setParent(obj.tabControl1);
    obj.tab8:setTitle("Magias");
    obj.tab8.grid.role = "col";
    obj.tab8.grid.width = 12;
    obj.tab8:setName("tab8");

    obj.button58 = GUI.fromHandle(_obj_newObject("button"));
    obj.button58:setParent(obj.tab8);
    obj.button58:setLeft(20);
    obj.button58:setTop(20);
    obj.button58:setHeight(25);
    obj.button58:setText("Nova Magia");
    obj.button58:setCursor("handPoint");
    obj.button58:setWidth(80);
    obj.button58:setName("button58");

    obj.layout82 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout82:setParent(obj.tab8);
    obj.layout82:setLeft(20);
    obj.layout82:setTop(48);
    obj.layout82:setHeight(25);
    obj.layout82:setWidth(1280);
    obj.layout82:setMargins({top=12});
    obj.layout82:setName("layout82");

    obj.label42 = GUI.fromHandle(_obj_newObject("label"));
    obj.label42:setParent(obj.layout82);
    obj.label42:setAlign("left");
    obj.label42:setText("Usos");
    obj.label42:setWidth(40);
    obj.label42:setMargins({right=5});
    obj.label42:setName("label42");

    obj.label43 = GUI.fromHandle(_obj_newObject("label"));
    obj.label43:setParent(obj.layout82);
    obj.label43:setAlign("left");
    obj.label43:setText("Total");
    obj.label43:setWidth(40);
    obj.label43:setMargins({right=5});
    obj.label43:setName("label43");

    obj.label44 = GUI.fromHandle(_obj_newObject("label"));
    obj.label44:setParent(obj.layout82);
    obj.label44:setAlign("left");
    obj.label44:setText("Tipo");
    obj.label44:setWidth(80);
    obj.label44:setMargins({right=5});
    obj.label44:setName("label44");

    obj.label45 = GUI.fromHandle(_obj_newObject("label"));
    obj.label45:setParent(obj.layout82);
    obj.label45:setAlign("left");
    obj.label45:setText("Nome");
    obj.label45:setWidth(160);
    obj.label45:setMargins({right=5});
    obj.label45:setName("label45");

    obj.label46 = GUI.fromHandle(_obj_newObject("label"));
    obj.label46:setParent(obj.layout82);
    obj.label46:setAlign("left");
    obj.label46:setText("Descrição");
    obj.label46:setWidth(600);
    obj.label46:setMargins({right=5});
    obj.label46:setName("label46");

    obj.label47 = GUI.fromHandle(_obj_newObject("label"));
    obj.label47:setParent(obj.layout82);
    obj.label47:setAlign("left");
    obj.label47:setText("Alcance");
    obj.label47:setWidth(80);
    obj.label47:setMargins({right=5});
    obj.label47:setName("label47");

    obj.label48 = GUI.fromHandle(_obj_newObject("label"));
    obj.label48:setParent(obj.layout82);
    obj.label48:setAlign("left");
    obj.label48:setText("Duração");
    obj.label48:setWidth(80);
    obj.label48:setName("label48");

    obj.rclMagias = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclMagias:setParent(obj.tab8);
    obj.rclMagias:setName("rclMagias");
    obj.rclMagias:setField("magias");
    obj.rclMagias:setTemplateForm("frmMagiasList");
    obj.rclMagias:setLeft(20);
    obj.rclMagias:setTop(72);
    obj.rclMagias:setWidth(1280);
    obj.rclMagias:setAutoHeight(true);

    obj.tab9 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab9:setParent(obj.tabControl1);
    obj.tab9:setTitle("Coisas");
    obj.tab9:setName("tab9");

    obj.button59 = GUI.fromHandle(_obj_newObject("button"));
    obj.button59:setParent(obj.tab9);
    obj.button59:setLeft(20);
    obj.button59:setTop(20);
    obj.button59:setHeight(25);
    obj.button59:setText("Novo Item");
    obj.button59:setCursor("handPoint");
    obj.button59:setWidth(80);
    obj.button59:setName("button59");

    obj.layout83 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout83:setParent(obj.tab9);
    obj.layout83:setLeft(20);
    obj.layout83:setTop(48);
    obj.layout83:setHeight(25);
    obj.layout83:setWidth(1280);
    obj.layout83:setMargins({top=12});
    obj.layout83:setName("layout83");

    obj.label49 = GUI.fromHandle(_obj_newObject("label"));
    obj.label49:setParent(obj.layout83);
    obj.label49:setAlign("left");
    obj.label49:setText("Nome");
    obj.label49:setWidth(160);
    obj.label49:setMargins({right=5});
    obj.label49:setName("label49");

    obj.label50 = GUI.fromHandle(_obj_newObject("label"));
    obj.label50:setParent(obj.layout83);
    obj.label50:setAlign("left");
    obj.label50:setText("Tipo");
    obj.label50:setWidth(100);
    obj.label50:setMargins({right=5});
    obj.label50:setName("label50");

    obj.label51 = GUI.fromHandle(_obj_newObject("label"));
    obj.label51:setParent(obj.layout83);
    obj.label51:setAlign("left");
    obj.label51:setText("Qtd.");
    obj.label51:setWidth(40);
    obj.label51:setMargins({right=5});
    obj.label51:setName("label51");

    obj.label52 = GUI.fromHandle(_obj_newObject("label"));
    obj.label52:setParent(obj.layout83);
    obj.label52:setAlign("left");
    obj.label52:setText("Peso");
    obj.label52:setWidth(40);
    obj.label52:setMargins({right=5});
    obj.label52:setName("label52");

    obj.label53 = GUI.fromHandle(_obj_newObject("label"));
    obj.label53:setParent(obj.layout83);
    obj.label53:setAlign("left");
    obj.label53:setText("Descrição");
    obj.label53:setWidth(600);
    obj.label53:setMargins({right=5});
    obj.label53:setName("label53");

    obj.label54 = GUI.fromHandle(_obj_newObject("label"));
    obj.label54:setParent(obj.layout83);
    obj.label54:setAlign("left");
    obj.label54:setText("Dur.Atual");
    obj.label54:setWidth(60);
    obj.label54:setMargins({right=5});
    obj.label54:setName("label54");

    obj.label55 = GUI.fromHandle(_obj_newObject("label"));
    obj.label55:setParent(obj.layout83);
    obj.label55:setAlign("left");
    obj.label55:setText("Dur.Total");
    obj.label55:setWidth(60);
    obj.label55:setName("label55");

    obj.rclItens = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclItens:setParent(obj.tab9);
    obj.rclItens:setName("rclItens");
    obj.rclItens:setField("itens");
    obj.rclItens:setTemplateForm("frmItensGerais");
    obj.rclItens:setLeft(20);
    obj.rclItens:setTop(72);
    obj.rclItens:setWidth(1280);
    obj.rclItens:setAutoHeight(true);

    obj.tab10 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab10:setParent(obj.tabControl1);
    obj.tab10:setTitle("Treinamentos");
    obj.tab10:setName("tab10");

    obj.layout84 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout84:setParent(obj.tab10);
    obj.layout84:setLeft(20);
    obj.layout84:setTop(0);
    obj.layout84:setHeight(500);
    obj.layout84:setWidth(1280);
    obj.layout84:setName("layout84");

    obj.layout85 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout85:setParent(obj.layout84);
    obj.layout85:setLeft(20);
    obj.layout85:setTop(48);
    obj.layout85:setHeight(25);
    obj.layout85:setWidth(1280);
    obj.layout85:setName("layout85");

    obj.label56 = GUI.fromHandle(_obj_newObject("label"));
    obj.label56:setParent(obj.layout85);
    obj.label56:setAlign("left");
    obj.label56:setText("Treino Principal");
    obj.label56:setWidth(160);
    obj.label56:setMargins({right=5});
    obj.label56:setName("label56");

    obj.label57 = GUI.fromHandle(_obj_newObject("label"));
    obj.label57:setParent(obj.layout85);
    obj.label57:setAlign("left");
    obj.label57:setText("Treino Secundário");
    obj.label57:setWidth(160);
    obj.label57:setMargins({right=5});
    obj.label57:setName("label57");

    obj.label58 = GUI.fromHandle(_obj_newObject("label"));
    obj.label58:setParent(obj.layout85);
    obj.label58:setAlign("left");
    obj.label58:setText("Int");
    obj.label58:setWidth(40);
    obj.label58:setMargins({right=5});
    obj.label58:setName("label58");

    obj.label59 = GUI.fromHandle(_obj_newObject("label"));
    obj.label59:setParent(obj.layout85);
    obj.label59:setAlign("left");
    obj.label59:setText("Sab");
    obj.label59:setWidth(40);
    obj.label59:setMargins({right=5});
    obj.label59:setName("label59");

    obj.label60 = GUI.fromHandle(_obj_newObject("label"));
    obj.label60:setParent(obj.layout85);
    obj.label60:setAlign("left");
    obj.label60:setText("Descrição do treinamento");
    obj.label60:setWidth(600);
    obj.label60:setMargins({right=5});
    obj.label60:setName("label60");

    obj.label61 = GUI.fromHandle(_obj_newObject("label"));
    obj.label61:setParent(obj.layout85);
    obj.label61:setAlign("left");
    obj.label61:setText("Tempo h.");
    obj.label61:setWidth(60);
    obj.label61:setMargins({right=5});
    obj.label61:setName("label61");

    obj.layout86 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout86:setParent(obj.layout84);
    obj.layout86:setLeft(20);
    obj.layout86:setTop(78);
    obj.layout86:setHeight(25);
    obj.layout86:setWidth(1280);
    obj.layout86:setName("layout86");

    obj.edit127 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit127:setParent(obj.layout86);
    obj.edit127:setAlign("left");
    obj.edit127:setHorzTextAlign("center");
    obj.edit127:setField("principalTreino1");
    obj.edit127:setWidth(160);
    obj.edit127:setHeight(25);
    obj.edit127:setMargins({right=5});
    obj.edit127:setName("edit127");

    obj.edit128 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit128:setParent(obj.layout86);
    obj.edit128:setAlign("left");
    obj.edit128:setHorzTextAlign("center");
    obj.edit128:setField("secundarioTreino1");
    obj.edit128:setWidth(160);
    obj.edit128:setHeight(25);
    obj.edit128:setMargins({right=5});
    obj.edit128:setName("edit128");

    obj.edit129 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit129:setParent(obj.layout86);
    obj.edit129:setAlign("left");
    obj.edit129:setHorzTextAlign("center");
    obj.edit129:setField("intTreino1");
    obj.edit129:setWidth(40);
    obj.edit129:setHeight(25);
    obj.edit129:setMargins({right=5});
    obj.edit129:setName("edit129");

    obj.edit130 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit130:setParent(obj.layout86);
    obj.edit130:setAlign("left");
    obj.edit130:setHorzTextAlign("center");
    obj.edit130:setField("sabTreino1");
    obj.edit130:setWidth(40);
    obj.edit130:setHeight(25);
    obj.edit130:setMargins({right=5});
    obj.edit130:setName("edit130");

    obj.edit131 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit131:setParent(obj.layout86);
    obj.edit131:setAlign("left");
    obj.edit131:setField("descTreino1");
    obj.edit131:setWidth(600);
    obj.edit131:setHeight(25);
    obj.edit131:setMargins({right=5});
    obj.edit131:setName("edit131");

    obj.edit132 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit132:setParent(obj.layout86);
    obj.edit132:setAlign("left");
    obj.edit132:setHorzTextAlign("center");
    obj.edit132:setField("tempoTreino1");
    obj.edit132:setWidth(60);
    obj.edit132:setHeight(25);
    obj.edit132:setMargins({right=5});
    obj.edit132:setName("edit132");

    obj.layout87 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout87:setParent(obj.layout84);
    obj.layout87:setLeft(20);
    obj.layout87:setTop(108);
    obj.layout87:setHeight(25);
    obj.layout87:setWidth(1280);
    obj.layout87:setName("layout87");

    obj.edit133 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit133:setParent(obj.layout87);
    obj.edit133:setAlign("left");
    obj.edit133:setHorzTextAlign("center");
    obj.edit133:setField("principalTreino2");
    obj.edit133:setWidth(160);
    obj.edit133:setHeight(25);
    obj.edit133:setMargins({right=5});
    obj.edit133:setName("edit133");

    obj.edit134 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit134:setParent(obj.layout87);
    obj.edit134:setAlign("left");
    obj.edit134:setHorzTextAlign("center");
    obj.edit134:setField("secundarioTreino2");
    obj.edit134:setWidth(160);
    obj.edit134:setHeight(25);
    obj.edit134:setMargins({right=5});
    obj.edit134:setName("edit134");

    obj.edit135 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit135:setParent(obj.layout87);
    obj.edit135:setAlign("left");
    obj.edit135:setHorzTextAlign("center");
    obj.edit135:setField("intTreino2");
    obj.edit135:setWidth(40);
    obj.edit135:setHeight(25);
    obj.edit135:setMargins({right=5});
    obj.edit135:setName("edit135");

    obj.edit136 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit136:setParent(obj.layout87);
    obj.edit136:setAlign("left");
    obj.edit136:setHorzTextAlign("center");
    obj.edit136:setField("sabTreino2");
    obj.edit136:setWidth(40);
    obj.edit136:setHeight(25);
    obj.edit136:setMargins({right=5});
    obj.edit136:setName("edit136");

    obj.edit137 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit137:setParent(obj.layout87);
    obj.edit137:setAlign("left");
    obj.edit137:setField("descTreino2");
    obj.edit137:setWidth(600);
    obj.edit137:setHeight(25);
    obj.edit137:setMargins({right=5});
    obj.edit137:setName("edit137");

    obj.edit138 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit138:setParent(obj.layout87);
    obj.edit138:setAlign("left");
    obj.edit138:setHorzTextAlign("center");
    obj.edit138:setField("tempoTreino2");
    obj.edit138:setWidth(60);
    obj.edit138:setHeight(25);
    obj.edit138:setMargins({right=5});
    obj.edit138:setName("edit138");

    obj.layout88 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout88:setParent(obj.layout84);
    obj.layout88:setLeft(20);
    obj.layout88:setTop(138);
    obj.layout88:setHeight(25);
    obj.layout88:setWidth(1280);
    obj.layout88:setName("layout88");

    obj.edit139 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit139:setParent(obj.layout88);
    obj.edit139:setAlign("left");
    obj.edit139:setHorzTextAlign("center");
    obj.edit139:setField("principalTreino3");
    obj.edit139:setWidth(160);
    obj.edit139:setHeight(25);
    obj.edit139:setMargins({right=5});
    obj.edit139:setName("edit139");

    obj.edit140 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit140:setParent(obj.layout88);
    obj.edit140:setAlign("left");
    obj.edit140:setHorzTextAlign("center");
    obj.edit140:setField("secundarioTreino3");
    obj.edit140:setWidth(160);
    obj.edit140:setHeight(25);
    obj.edit140:setMargins({right=5});
    obj.edit140:setName("edit140");

    obj.edit141 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit141:setParent(obj.layout88);
    obj.edit141:setAlign("left");
    obj.edit141:setHorzTextAlign("center");
    obj.edit141:setField("intTreino3");
    obj.edit141:setWidth(40);
    obj.edit141:setHeight(25);
    obj.edit141:setMargins({right=5});
    obj.edit141:setName("edit141");

    obj.edit142 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit142:setParent(obj.layout88);
    obj.edit142:setAlign("left");
    obj.edit142:setHorzTextAlign("center");
    obj.edit142:setField("sabTreino3");
    obj.edit142:setWidth(40);
    obj.edit142:setHeight(25);
    obj.edit142:setMargins({right=5});
    obj.edit142:setName("edit142");

    obj.edit143 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit143:setParent(obj.layout88);
    obj.edit143:setAlign("left");
    obj.edit143:setField("descTreino3");
    obj.edit143:setWidth(600);
    obj.edit143:setHeight(25);
    obj.edit143:setMargins({right=5});
    obj.edit143:setName("edit143");

    obj.edit144 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit144:setParent(obj.layout88);
    obj.edit144:setAlign("left");
    obj.edit144:setHorzTextAlign("center");
    obj.edit144:setField("tempoTreino3");
    obj.edit144:setWidth(60);
    obj.edit144:setHeight(25);
    obj.edit144:setMargins({right=5});
    obj.edit144:setName("edit144");

    obj.tab11 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab11:setParent(obj.tabControl1);
    obj.tab11:setTitle("Conhecimentos");
    obj.tab11:setName("tab11");

    obj.richEdit1 = GUI.fromHandle(_obj_newObject("richEdit"));
    obj.richEdit1:setParent(obj.tab11);
    obj.richEdit1:setAlign("client");
    obj.richEdit1.backgroundColor = "white";
    obj.richEdit1.defaultFontColor = "black";
    obj.richEdit1:setField("conhecimentos");
    obj.richEdit1:setName("richEdit1");

    obj.tab12 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab12:setParent(obj.tabControl1);
    obj.tab12:setTitle("Lore");
    obj.tab12:setName("tab12");

    obj.richEdit2 = GUI.fromHandle(_obj_newObject("richEdit"));
    obj.richEdit2:setParent(obj.tab12);
    obj.richEdit2:setAlign("client");
    obj.richEdit2.backgroundColor = "white";
    obj.richEdit2.defaultFontColor = "black";
    obj.richEdit2:setField("lore");
    obj.richEdit2:setName("richEdit2");

    obj._e_event0 = obj.dataLink1:addEventListener("onChange",
        function (field, oldValue, newValue)
            local sorteValue = sheet.sorte or 0;
                        local modValue = sheet.sorteMod or 0;                   
            
                        sheet.sorteRes = sorteValue + modValue;
        end);

    obj._e_event1 = obj.button1:addEventListener("onClick",
        function (event)
            local rolagem = Firecast.interpretarRolagem(sheet.sorteDoPersonagem); 
            
                            if not rolagem.possuiAlgumDado then
                                rolagem = Firecast.interpretarRolagem("1d20"):concatenar(rolagem);
                            end; 
            
                            local mesaDoPersonagem = Firecast.getMesaDe(sheet);
            
                            if mesaDoPersonagem ~= nil then
                                    mesaDoPersonagem.chat:rolarDados(rolagem, "Sorte");
                            end;
        end);

    obj._e_event2 = obj.button2:addEventListener("onClick",
        function (event)
            dadoPadrao("Vital", sheet.vital, sheet.vitalDoPersonagem, sheet.vitalMod);
        end);

    obj._e_event3 = obj.button3:addEventListener("onClick",
        function (event)
            dadoPadrao("Adrenalina", sheet.adrenalina, sheet.adrenalinaDoPersonagem, sheet.adrenalinaMod);
        end);

    obj._e_event4 = obj.button4:addEventListener("onClick",
        function (event)
            dadoPadrao("Ataque", sheet.ataque, sheet.ataqueDoPersonagem, sheet.ataqueMod);
        end);

    obj._e_event5 = obj.button5:addEventListener("onClick",
        function (event)
            dadoPadrao("Defesa", sheet.defesa, sheet.defesaDoPersonagem, sheet.defesaMod);
        end);

    obj._e_event6 = obj.button6:addEventListener("onClick",
        function (event)
            dadoPadrao("Destreza", sheet.destreza, sheet.destrezaDoPersonagem, sheet.destrezaMod);
        end);

    obj._e_event7 = obj.button7:addEventListener("onClick",
        function (event)
            dadoPadrao("Força", sheet.forca, sheet.forcaDoPersonagem, sheet.forcaMod);
        end);

    obj._e_event8 = obj.button8:addEventListener("onClick",
        function (event)
            dadoPadrao("Inteligencia", sheet.inteligencia, sheet.inteligenciaDoPersonagem, sheet.inteligenciaMod);
        end);

    obj._e_event9 = obj.button9:addEventListener("onClick",
        function (event)
            dadoPadrao("Resistência", sheet.resistencia, sheet.resistenciaDoPersonagem, sheet.resistenciaMod);
        end);

    obj._e_event10 = obj.button10:addEventListener("onClick",
        function (event)
            dadoPadrao("Sabedoria", sheet.sabedoria, sheet.sabedoriaDoPersonagem, sheet.sabedoriaMod);
        end);

    obj._e_event11 = obj.button11:addEventListener("onClick",
        function (event)
            dadoPadrao("Velocidade", sheet.velocidade, sheet.velocidadeDoPersonagem, sheet.velocidadeMod);
        end);

    obj._e_event12 = obj.button12:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testeDesvantagem1) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.desvantagem1, sheet.testeDesvantagem1, sheet.testeDesvantagem1DoPersonagem);
                                    else
                                        dadoPadrao(sheet.desvantagem1, sheet.testeDesvantagem1, sheet.testeDesvantagem1DoPersonagem);
                                    end;
        end);

    obj._e_event13 = obj.button13:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testeDesvantagem2) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.desvantagem2, sheet.testeDesvantagem2, sheet.testeDesvantagem2DoPersonagem);
                                    else
                                        dadoPadrao(sheet.desvantagem2, sheet.testeDesvantagem2, sheet.testeDesvantagem2DoPersonagem);
                                    end;
        end);

    obj._e_event14 = obj.button14:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testeDesvantagem3) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.desvantagem3, sheet.testeDesvantagem3, sheet.testeDesvantagem3DoPersonagem);
                                    else
                                        dadoPadrao(sheet.desvantagem3, sheet.testeDesvantagem3, sheet.testeDesvantagem3DoPersonagem);
                                    end;
        end);

    obj._e_event15 = obj.button15:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testeDesvantagem4) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.desvantagem4, sheet.testeDesvantagem4, sheet.testeDesvantagem4DoPersonagem);
                                    else
                                        dadoPadrao(sheet.desvantagem4, sheet.testeDesvantagem4, sheet.testeDesvantagem4DoPersonagem);
                                    end;
        end);

    obj._e_event16 = obj.button16:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testeDesvantagem5) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.desvantagem5, sheet.testeDesvantagem5, sheet.testeDesvantagem5DoPersonagem);
                                    else
                                        dadoPadrao(sheet.desvantagem5, sheet.testeDesvantagem5, sheet.testeDesvantagem5DoPersonagem);
                                    end;
        end);

    obj._e_event17 = obj.button17:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testeDesvantagem6) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.desvantagem6, sheet.testeDesvantagem6, sheet.testeDesvantagem6DoPersonagem);
                                    else
                                        dadoPadrao(sheet.desvantagem6, sheet.testeDesvantagem6, sheet.testeDesvantagem6DoPersonagem);
                                    end;
        end);

    obj._e_event18 = obj.button18:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testeDesvantagem7) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.desvantagem7, sheet.testeDesvantagem7, sheet.testeDesvantagem7DoPersonagem);
                                    else
                                        dadoPadrao(sheet.desvantagem7, sheet.testeDesvantagem7, sheet.testeDesvantagem7DoPersonagem);
                                    end;
        end);

    obj._e_event19 = obj.button19:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testeDesvantagem8) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.desvantagem8, sheet.testeDesvantagem8, sheet.testeDesvantagem8DoPersonagem);
                                    else
                                        dadoPadrao(sheet.desvantagem8, sheet.testeDesvantagem8, sheet.testeDesvantagem8DoPersonagem);
                                    end;
        end);

    obj._e_event20 = obj.button20:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade1, sheet.testeCapacidade1, sheet.testeCapacidade1DoPersonagem);
        end);

    obj._e_event21 = obj.button21:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade2, sheet.testeCapacidade2, sheet.testeCapacidade2DoPersonagem);
        end);

    obj._e_event22 = obj.button22:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade3, sheet.testeCapacidade3, sheet.testeCapacidade3DoPersonagem);
        end);

    obj._e_event23 = obj.button23:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade4, sheet.testeCapacidade4, sheet.testeCapacidade4DoPersonagem);
        end);

    obj._e_event24 = obj.button24:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade5, sheet.testeCapacidade5, sheet.testeCapacidade5DoPersonagem);
        end);

    obj._e_event25 = obj.button25:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade6, sheet.testeCapacidade6, sheet.testeCapacidade6DoPersonagem);
        end);

    obj._e_event26 = obj.button26:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade7, sheet.testeCapacidade7, sheet.testeCapacidade7DoPersonagem);
        end);

    obj._e_event27 = obj.button27:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade8, sheet.testeCapacidade8, sheet.testeCapacidade8DoPersonagem);
        end);

    obj._e_event28 = obj.button28:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.moviApri1, sheet.testeMoviApri1, sheet.testeMoviApri1DoPersonagem);
        end);

    obj._e_event29 = obj.button29:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.moviApri2, sheet.testeMoviApri2, sheet.testeMoviApri2DoPersonagem);
        end);

    obj._e_event30 = obj.button30:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.moviApri3, sheet.testeMoviApri3, sheet.testeMoviApri3DoPersonagem);
        end);

    obj._e_event31 = obj.button31:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade16, sheet.testeCapacidade16, sheet.testeCapacidade16DoPersonagem);
        end);

    obj._e_event32 = obj.button32:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade9, sheet.testeCapacidade9, sheet.testeCapacidade9DoPersonagem);
        end);

    obj._e_event33 = obj.button33:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade10, sheet.testeCapacidade10, sheet.testeCapacidade10DoPersonagem);
        end);

    obj._e_event34 = obj.button34:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade11, sheet.testeCapacidade11, sheet.testeCapacidade11DoPersonagem);
        end);

    obj._e_event35 = obj.button35:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade12, sheet.testeCapacidade12, sheet.testeCapacidade12DoPersonagem);
        end);

    obj._e_event36 = obj.button36:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade13, sheet.testeCapacidade13, sheet.testeCapacidade13DoPersonagem);
        end);

    obj._e_event37 = obj.button37:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade14, sheet.testeCapacidade14, sheet.testeCapacidade14DoPersonagem);
        end);

    obj._e_event38 = obj.button38:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.capacidade15, sheet.testeCapacidade15, sheet.testeCapacidade15DoPersonagem);
        end);

    obj._e_event39 = obj.button39:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.moviApri4, sheet.testeMoviApri4, sheet.testeMoviApri4DoPersonagem);
        end);

    obj._e_event40 = obj.button40:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.moviApri5, sheet.testeMoviApri5, sheet.testeMoviApri5DoPersonagem);
        end);

    obj._e_event41 = obj.button41:addEventListener("onClick",
        function (event)
            dadoPadrao(sheet.moviApri6, sheet.testeMoviApri6, sheet.testeMoviApri6DoPersonagem);
        end);

    obj._e_event42 = obj.button42:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia1) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia1, sheet.testePericia1, sheet.testePericia1DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia1, sheet.testePericia1, sheet.testePericia1DoPersonagem);
                                    end;
        end);

    obj._e_event43 = obj.button43:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia2) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia2, sheet.testePericia2, sheet.testePericia2DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia2, sheet.testePericia2, sheet.testePericia2DoPersonagem);
                                    end;
        end);

    obj._e_event44 = obj.button44:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia3) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia3, sheet.testePericia3, sheet.testePericia3DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia3, sheet.testePericia3, sheet.testePericia3DoPersonagem);
                                    end;
        end);

    obj._e_event45 = obj.button45:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia4) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia4, sheet.testePericia4, sheet.testePericia4DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia4, sheet.testePericia4, sheet.testePericia4DoPersonagem);
                                    end;
        end);

    obj._e_event46 = obj.button46:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia5) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia5, sheet.testePericia5, sheet.testePericia5DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia5, sheet.testePericia5, sheet.testePericia5DoPersonagem);
                                    end;
        end);

    obj._e_event47 = obj.button47:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia6) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia6, sheet.testePericia6, sheet.testePericia6DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia6, sheet.testePericia6, sheet.testePericia6DoPersonagem);
                                    end;
        end);

    obj._e_event48 = obj.button48:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia7) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia7, sheet.testePericia7, sheet.testePericia7DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia7, sheet.testePericia7, sheet.testePericia7DoPersonagem);
                                    end;
        end);

    obj._e_event49 = obj.button49:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia8) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia8, sheet.testePericia8, sheet.testePericia8DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia8, sheet.testePericia8, sheet.testePericia8DoPersonagem);
                                    end;
        end);

    obj._e_event50 = obj.button50:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia9) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia9, sheet.testePericia9, sheet.testePericia9DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia9, sheet.testePericia9, sheet.testePericia9DoPersonagem);
                                    end;
        end);

    obj._e_event51 = obj.button51:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia10) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia10, sheet.testePericia10, sheet.testePericia10DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia10, sheet.testePericia10, sheet.testePericia10DoPersonagem);
                                    end;
        end);

    obj._e_event52 = obj.button52:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia11) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia11, sheet.testePericia11, sheet.testePericia11DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia11, sheet.testePericia11, sheet.testePericia11DoPersonagem);
                                    end;
        end);

    obj._e_event53 = obj.button53:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia12) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia12, sheet.testePericia12, sheet.testePericia12DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia12, sheet.testePericia12, sheet.testePericia12DoPersonagem);
                                    end;
        end);

    obj._e_event54 = obj.button54:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia13) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia13, sheet.testePericia13, sheet.testePericia13DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia13, sheet.testePericia13, sheet.testePericia13DoPersonagem);
                                    end;
        end);

    obj._e_event55 = obj.button55:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia14) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia14, sheet.testePericia14, sheet.testePericia14DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia14, sheet.testePericia14, sheet.testePericia14DoPersonagem);
                                    end;
        end);

    obj._e_event56 = obj.button56:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia15) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia15, sheet.testePericia15, sheet.testePericia15DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia15, sheet.testePericia15, sheet.testePericia15DoPersonagem);
                                    end;
        end);

    obj._e_event57 = obj.button57:addEventListener("onClick",
        function (event)
            local teste = tonumber(sheet.testePericia16) or 0;
            
                                    if teste == 1 or teste == 2 or teste == 3 or teste == 4 or teste == 5 or teste == 6 or teste == 7 or teste == 8 or teste == 9 or teste == 10 or teste == 11 or teste == 12 or teste == 13 or teste == 14 or teste == 15 or teste == 16 or teste == 17 or teste == 18  then
                                        dado20(sheet.Pericia16, sheet.testePericia16, sheet.testePericia16DoPersonagem);
                                    else
                                        dadoPadrao(sheet.Pericia16, sheet.testePericia16, sheet.testePericia16DoPersonagem);
                                    end;
        end);

    obj._e_event58 = obj.button58:addEventListener("onClick",
        function (event)
            self.rclMagias:append();
        end);

    obj._e_event59 = obj.button59:addEventListener("onClick",
        function (event)
            self.rclItens:append();
        end);

    function obj:_releaseEvents()
        __o_rrpgObjs.removeEventListenerById(self._e_event59);
        __o_rrpgObjs.removeEventListenerById(self._e_event58);
        __o_rrpgObjs.removeEventListenerById(self._e_event57);
        __o_rrpgObjs.removeEventListenerById(self._e_event56);
        __o_rrpgObjs.removeEventListenerById(self._e_event55);
        __o_rrpgObjs.removeEventListenerById(self._e_event54);
        __o_rrpgObjs.removeEventListenerById(self._e_event53);
        __o_rrpgObjs.removeEventListenerById(self._e_event52);
        __o_rrpgObjs.removeEventListenerById(self._e_event51);
        __o_rrpgObjs.removeEventListenerById(self._e_event50);
        __o_rrpgObjs.removeEventListenerById(self._e_event49);
        __o_rrpgObjs.removeEventListenerById(self._e_event48);
        __o_rrpgObjs.removeEventListenerById(self._e_event47);
        __o_rrpgObjs.removeEventListenerById(self._e_event46);
        __o_rrpgObjs.removeEventListenerById(self._e_event45);
        __o_rrpgObjs.removeEventListenerById(self._e_event44);
        __o_rrpgObjs.removeEventListenerById(self._e_event43);
        __o_rrpgObjs.removeEventListenerById(self._e_event42);
        __o_rrpgObjs.removeEventListenerById(self._e_event41);
        __o_rrpgObjs.removeEventListenerById(self._e_event40);
        __o_rrpgObjs.removeEventListenerById(self._e_event39);
        __o_rrpgObjs.removeEventListenerById(self._e_event38);
        __o_rrpgObjs.removeEventListenerById(self._e_event37);
        __o_rrpgObjs.removeEventListenerById(self._e_event36);
        __o_rrpgObjs.removeEventListenerById(self._e_event35);
        __o_rrpgObjs.removeEventListenerById(self._e_event34);
        __o_rrpgObjs.removeEventListenerById(self._e_event33);
        __o_rrpgObjs.removeEventListenerById(self._e_event32);
        __o_rrpgObjs.removeEventListenerById(self._e_event31);
        __o_rrpgObjs.removeEventListenerById(self._e_event30);
        __o_rrpgObjs.removeEventListenerById(self._e_event29);
        __o_rrpgObjs.removeEventListenerById(self._e_event28);
        __o_rrpgObjs.removeEventListenerById(self._e_event27);
        __o_rrpgObjs.removeEventListenerById(self._e_event26);
        __o_rrpgObjs.removeEventListenerById(self._e_event25);
        __o_rrpgObjs.removeEventListenerById(self._e_event24);
        __o_rrpgObjs.removeEventListenerById(self._e_event23);
        __o_rrpgObjs.removeEventListenerById(self._e_event22);
        __o_rrpgObjs.removeEventListenerById(self._e_event21);
        __o_rrpgObjs.removeEventListenerById(self._e_event20);
        __o_rrpgObjs.removeEventListenerById(self._e_event19);
        __o_rrpgObjs.removeEventListenerById(self._e_event18);
        __o_rrpgObjs.removeEventListenerById(self._e_event17);
        __o_rrpgObjs.removeEventListenerById(self._e_event16);
        __o_rrpgObjs.removeEventListenerById(self._e_event15);
        __o_rrpgObjs.removeEventListenerById(self._e_event14);
        __o_rrpgObjs.removeEventListenerById(self._e_event13);
        __o_rrpgObjs.removeEventListenerById(self._e_event12);
        __o_rrpgObjs.removeEventListenerById(self._e_event11);
        __o_rrpgObjs.removeEventListenerById(self._e_event10);
        __o_rrpgObjs.removeEventListenerById(self._e_event9);
        __o_rrpgObjs.removeEventListenerById(self._e_event8);
        __o_rrpgObjs.removeEventListenerById(self._e_event7);
        __o_rrpgObjs.removeEventListenerById(self._e_event6);
        __o_rrpgObjs.removeEventListenerById(self._e_event5);
        __o_rrpgObjs.removeEventListenerById(self._e_event4);
        __o_rrpgObjs.removeEventListenerById(self._e_event3);
        __o_rrpgObjs.removeEventListenerById(self._e_event2);
        __o_rrpgObjs.removeEventListenerById(self._e_event1);
        __o_rrpgObjs.removeEventListenerById(self._e_event0);
    end;

    obj._oldLFMDestroy = obj.destroy;

    function obj:destroy() 
        self:_releaseEvents();

        if (self.handle ~= 0) and (self.setNodeDatabase ~= nil) then
          self:setNodeDatabase(nil);
        end;

        if self.layout8 ~= nil then self.layout8:destroy(); self.layout8 = nil; end;
        if self.edit90 ~= nil then self.edit90:destroy(); self.edit90 = nil; end;
        if self.edit77 ~= nil then self.edit77:destroy(); self.edit77 = nil; end;
        if self.style ~= nil then self.style:destroy(); self.style = nil; end;
        if self.edit47 ~= nil then self.edit47:destroy(); self.edit47 = nil; end;
        if self.layout11 ~= nil then self.layout11:destroy(); self.layout11 = nil; end;
        if self.imageCheckBox1 ~= nil then self.imageCheckBox1:destroy(); self.imageCheckBox1 = nil; end;
        if self.edit88 ~= nil then self.edit88:destroy(); self.edit88 = nil; end;
        if self.edit30 ~= nil then self.edit30:destroy(); self.edit30 = nil; end;
        if self.edit119 ~= nil then self.edit119:destroy(); self.edit119 = nil; end;
        if self.layout3 ~= nil then self.layout3:destroy(); self.layout3 = nil; end;
        if self.edit95 ~= nil then self.edit95:destroy(); self.edit95 = nil; end;
        if self.edit70 ~= nil then self.edit70:destroy(); self.edit70 = nil; end;
        if self.edit42 ~= nil then self.edit42:destroy(); self.edit42 = nil; end;
        if self.layout43 ~= nil then self.layout43:destroy(); self.layout43 = nil; end;
        if self.label37 ~= nil then self.label37:destroy(); self.label37 = nil; end;
        if self.edit123 ~= nil then self.edit123:destroy(); self.edit123 = nil; end;
        if self.button11 ~= nil then self.button11:destroy(); self.button11 = nil; end;
        if self.button25 ~= nil then self.button25:destroy(); self.button25 = nil; end;
        if self.imageCheckBox4 ~= nil then self.imageCheckBox4:destroy(); self.imageCheckBox4 = nil; end;
        if self.edit35 ~= nil then self.edit35:destroy(); self.edit35 = nil; end;
        if self.layout70 ~= nil then self.layout70:destroy(); self.layout70 = nil; end;
        if self.edit49 ~= nil then self.edit49:destroy(); self.edit49 = nil; end;
        if self.layout46 ~= nil then self.layout46:destroy(); self.layout46 = nil; end;
        if self.edit124 ~= nil then self.edit124:destroy(); self.edit124 = nil; end;
        if self.button28 ~= nil then self.button28:destroy(); self.button28 = nil; end;
        if self.button57 ~= nil then self.button57:destroy(); self.button57 = nil; end;
        if self.edit82 ~= nil then self.edit82:destroy(); self.edit82 = nil; end;
        if self.edit27 ~= nil then self.edit27:destroy(); self.edit27 = nil; end;
        if self.layout75 ~= nil then self.layout75:destroy(); self.layout75 = nil; end;
        if self.label10 ~= nil then self.label10:destroy(); self.label10 = nil; end;
        if self.label22 ~= nil then self.label22:destroy(); self.label22 = nil; end;
        if self.edit14 ~= nil then self.edit14:destroy(); self.edit14 = nil; end;
        if self.edit59 ~= nil then self.edit59:destroy(); self.edit59 = nil; end;
        if self.layout49 ~= nil then self.layout49:destroy(); self.layout49 = nil; end;
        if self.button50 ~= nil then self.button50:destroy(); self.button50 = nil; end;
        if self.edit9 ~= nil then self.edit9:destroy(); self.edit9 = nil; end;
        if self.edit108 ~= nil then self.edit108:destroy(); self.edit108 = nil; end;
        if self.edit65 ~= nil then self.edit65:destroy(); self.edit65 = nil; end;
        if self.layout37 ~= nil then self.layout37:destroy(); self.layout37 = nil; end;
        if self.tab11 ~= nil then self.tab11:destroy(); self.tab11 = nil; end;
        if self.label15 ~= nil then self.label15:destroy(); self.label15 = nil; end;
        if self.label29 ~= nil then self.label29:destroy(); self.label29 = nil; end;
        if self.label56 ~= nil then self.label56:destroy(); self.label56 = nil; end;
        if self.edit56 ~= nil then self.edit56:destroy(); self.edit56 = nil; end;
        if self.layout59 ~= nil then self.layout59:destroy(); self.layout59 = nil; end;
        if self.button44 ~= nil then self.button44:destroy(); self.button44 = nil; end;
        if self.edit60 ~= nil then self.edit60:destroy(); self.edit60 = nil; end;
        if self.layout25 ~= nil then self.layout25:destroy(); self.layout25 = nil; end;
        if self.edit131 ~= nil then self.edit131:destroy(); self.edit131 = nil; end;
        if self.layout84 ~= nil then self.layout84:destroy(); self.layout84 = nil; end;
        if self.label53 ~= nil then self.label53:destroy(); self.label53 = nil; end;
        if self.edit53 ~= nil then self.edit53:destroy(); self.edit53 = nil; end;
        if self.layout52 ~= nil then self.layout52:destroy(); self.layout52 = nil; end;
        if self.layout60 ~= nil then self.layout60:destroy(); self.layout60 = nil; end;
        if self.edit3 ~= nil then self.edit3:destroy(); self.edit3 = nil; end;
        if self.button8 ~= nil then self.button8:destroy(); self.button8 = nil; end;
        if self.button34 ~= nil then self.button34:destroy(); self.button34 = nil; end;
        if self.layout20 ~= nil then self.layout20:destroy(); self.layout20 = nil; end;
        if self.edit102 ~= nil then self.edit102:destroy(); self.edit102 = nil; end;
        if self.label39 ~= nil then self.label39:destroy(); self.label39 = nil; end;
        if self.edit134 ~= nil then self.edit134:destroy(); self.edit134 = nil; end;
        if self.edit142 ~= nil then self.edit142:destroy(); self.edit142 = nil; end;
        if self.label45 ~= nil then self.label45:destroy(); self.label45 = nil; end;
        if self.tab1 ~= nil then self.tab1:destroy(); self.tab1 = nil; end;
        if self.layout57 ~= nil then self.layout57:destroy(); self.layout57 = nil; end;
        if self.layout18 ~= nil then self.layout18:destroy(); self.layout18 = nil; end;
        if self.edit6 ~= nil then self.edit6:destroy(); self.edit6 = nil; end;
        if self.button3 ~= nil then self.button3:destroy(); self.button3 = nil; end;
        if self.layout67 ~= nil then self.layout67:destroy(); self.layout67 = nil; end;
        if self.edit107 ~= nil then self.edit107:destroy(); self.edit107 = nil; end;
        if self.image1 ~= nil then self.image1:destroy(); self.image1 = nil; end;
        if self.label40 ~= nil then self.label40:destroy(); self.label40 = nil; end;
        if self.label9 ~= nil then self.label9:destroy(); self.label9 = nil; end;
        if self.layout15 ~= nil then self.layout15:destroy(); self.layout15 = nil; end;
        if self.button18 ~= nil then self.button18:destroy(); self.button18 = nil; end;
        if self.button6 ~= nil then self.button6:destroy(); self.button6 = nil; end;
        if self.label33 ~= nil then self.label33:destroy(); self.label33 = nil; end;
        if self.edit115 ~= nil then self.edit115:destroy(); self.edit115 = nil; end;
        if self.layout7 ~= nil then self.layout7:destroy(); self.layout7 = nil; end;
        if self.edit91 ~= nil then self.edit91:destroy(); self.edit91 = nil; end;
        if self.edit74 ~= nil then self.edit74:destroy(); self.edit74 = nil; end;
        if self.edit46 ~= nil then self.edit46:destroy(); self.edit46 = nil; end;
        if self.button21 ~= nil then self.button21:destroy(); self.button21 = nil; end;
        if self.edit118 ~= nil then self.edit118:destroy(); self.edit118 = nil; end;
        if self.edit31 ~= nil then self.edit31:destroy(); self.edit31 = nil; end;
        if self.layout2 ~= nil then self.layout2:destroy(); self.layout2 = nil; end;
        if self.edit96 ~= nil then self.edit96:destroy(); self.edit96 = nil; end;
        if self.edit71 ~= nil then self.edit71:destroy(); self.edit71 = nil; end;
        if self.layout42 ~= nil then self.layout42:destroy(); self.layout42 = nil; end;
        if self.edit120 ~= nil then self.edit120:destroy(); self.edit120 = nil; end;
        if self.label7 ~= nil then self.label7:destroy(); self.label7 = nil; end;
        if self.button16 ~= nil then self.button16:destroy(); self.button16 = nil; end;
        if self.button24 ~= nil then self.button24:destroy(); self.button24 = nil; end;
        if self.edit23 ~= nil then self.edit23:destroy(); self.edit23 = nil; end;
        if self.progressBar1 ~= nil then self.progressBar1:destroy(); self.progressBar1 = nil; end;
        if self.layout71 ~= nil then self.layout71:destroy(); self.layout71 = nil; end;
        if self.richEdit1 ~= nil then self.richEdit1:destroy(); self.richEdit1 = nil; end;
        if self.tabControl1 ~= nil then self.tabControl1:destroy(); self.tabControl1 = nil; end;
        if self.edit48 ~= nil then self.edit48:destroy(); self.edit48 = nil; end;
        if self.layout45 ~= nil then self.layout45:destroy(); self.layout45 = nil; end;
        if self.edit125 ~= nil then self.edit125:destroy(); self.edit125 = nil; end;
        if self.edit10 ~= nil then self.edit10:destroy(); self.edit10 = nil; end;
        if self.button54 ~= nil then self.button54:destroy(); self.button54 = nil; end;
        if self.edit85 ~= nil then self.edit85:destroy(); self.edit85 = nil; end;
        if self.edit26 ~= nil then self.edit26:destroy(); self.edit26 = nil; end;
        if self.layout76 ~= nil then self.layout76:destroy(); self.layout76 = nil; end;
        if self.label11 ~= nil then self.label11:destroy(); self.label11 = nil; end;
        if self.label25 ~= nil then self.label25:destroy(); self.label25 = nil; end;
        if self.edit15 ~= nil then self.edit15:destroy(); self.edit15 = nil; end;
        if self.layout48 ~= nil then self.layout48:destroy(); self.layout48 = nil; end;
        if self.button51 ~= nil then self.button51:destroy(); self.button51 = nil; end;
        if self.edit8 ~= nil then self.edit8:destroy(); self.edit8 = nil; end;
        if self.edit29 ~= nil then self.edit29:destroy(); self.edit29 = nil; end;
        if self.edit64 ~= nil then self.edit64:destroy(); self.edit64 = nil; end;
        if self.layout30 ~= nil then self.layout30:destroy(); self.layout30 = nil; end;
        if self.edit109 ~= nil then self.edit109:destroy(); self.edit109 = nil; end;
        if self.tab10 ~= nil then self.tab10:destroy(); self.tab10 = nil; end;
        if self.layout88 ~= nil then self.layout88:destroy(); self.layout88 = nil; end;
        if self.label28 ~= nil then self.label28:destroy(); self.label28 = nil; end;
        if self.tab8 ~= nil then self.tab8:destroy(); self.tab8 = nil; end;
        if self.edit57 ~= nil then self.edit57:destroy(); self.edit57 = nil; end;
        if self.button43 ~= nil then self.button43:destroy(); self.button43 = nil; end;
        if self.label57 ~= nil then self.label57:destroy(); self.label57 = nil; end;
        if self.button30 ~= nil then self.button30:destroy(); self.button30 = nil; end;
        if self.layout24 ~= nil then self.layout24:destroy(); self.layout24 = nil; end;
        if self.edit130 ~= nil then self.edit130:destroy(); self.edit130 = nil; end;
        if self.layout83 ~= nil then self.layout83:destroy(); self.layout83 = nil; end;
        if self.label50 ~= nil then self.label50:destroy(); self.label50 = nil; end;
        if self.layout53 ~= nil then self.layout53:destroy(); self.layout53 = nil; end;
        if self.layout63 ~= nil then self.layout63:destroy(); self.layout63 = nil; end;
        if self.edit2 ~= nil then self.edit2:destroy(); self.edit2 = nil; end;
        if self.edit103 ~= nil then self.edit103:destroy(); self.edit103 = nil; end;
        if self.button35 ~= nil then self.button35:destroy(); self.button35 = nil; end;
        if self.layout23 ~= nil then self.layout23:destroy(); self.layout23 = nil; end;
        if self.edit143 ~= nil then self.edit143:destroy(); self.edit143 = nil; end;
        if self.label44 ~= nil then self.label44:destroy(); self.label44 = nil; end;
        if self.tab6 ~= nil then self.tab6:destroy(); self.tab6 = nil; end;
        if self.layout54 ~= nil then self.layout54:destroy(); self.layout54 = nil; end;
        if self.layout19 ~= nil then self.layout19:destroy(); self.layout19 = nil; end;
        if self.layout66 ~= nil then self.layout66:destroy(); self.layout66 = nil; end;
        if self.button2 ~= nil then self.button2:destroy(); self.button2 = nil; end;
        if self.edit38 ~= nil then self.edit38:destroy(); self.edit38 = nil; end;
        if self.button49 ~= nil then self.button49:destroy(); self.button49 = nil; end;
        if self.edit111 ~= nil then self.edit111:destroy(); self.edit111 = nil; end;
        if self.edit78 ~= nil then self.edit78:destroy(); self.edit78 = nil; end;
        if self.label8 ~= nil then self.label8:destroy(); self.label8 = nil; end;
        if self.layout12 ~= nil then self.layout12:destroy(); self.layout12 = nil; end;
        if self.button19 ~= nil then self.button19:destroy(); self.button19 = nil; end;
        if self.button5 ~= nil then self.button5:destroy(); self.button5 = nil; end;
        if self.label34 ~= nil then self.label34:destroy(); self.label34 = nil; end;
        if self.edit114 ~= nil then self.edit114:destroy(); self.edit114 = nil; end;
        if self.layout6 ~= nil then self.layout6:destroy(); self.layout6 = nil; end;
        if self.edit92 ~= nil then self.edit92:destroy(); self.edit92 = nil; end;
        if self.edit75 ~= nil then self.edit75:destroy(); self.edit75 = nil; end;
        if self.edit41 ~= nil then self.edit41:destroy(); self.edit41 = nil; end;
        if self.layout78 ~= nil then self.layout78:destroy(); self.layout78 = nil; end;
        if self.label3 ~= nil then self.label3:destroy(); self.label3 = nil; end;
        if self.button12 ~= nil then self.button12:destroy(); self.button12 = nil; end;
        if self.imageCheckBox3 ~= nil then self.imageCheckBox3:destroy(); self.imageCheckBox3 = nil; end;
        if self.button20 ~= nil then self.button20:destroy(); self.button20 = nil; end;
        if self.edit36 ~= nil then self.edit36:destroy(); self.edit36 = nil; end;
        if self.layout1 ~= nil then self.layout1:destroy(); self.layout1 = nil; end;
        if self.edit97 ~= nil then self.edit97:destroy(); self.edit97 = nil; end;
        if self.label18 ~= nil then self.label18:destroy(); self.label18 = nil; end;
        if self.layout41 ~= nil then self.layout41:destroy(); self.layout41 = nil; end;
        if self.edit121 ~= nil then self.edit121:destroy(); self.edit121 = nil; end;
        if self.label6 ~= nil then self.label6:destroy(); self.label6 = nil; end;
        if self.button17 ~= nil then self.button17:destroy(); self.button17 = nil; end;
        if self.button27 ~= nil then self.button27:destroy(); self.button27 = nil; end;
        if self.edit81 ~= nil then self.edit81:destroy(); self.edit81 = nil; end;
        if self.edit22 ~= nil then self.edit22:destroy(); self.edit22 = nil; end;
        if self.layout72 ~= nil then self.layout72:destroy(); self.layout72 = nil; end;
        if self.button58 ~= nil then self.button58:destroy(); self.button58 = nil; end;
        if self.rclItens ~= nil then self.rclItens:destroy(); self.rclItens = nil; end;
        if self.layout44 ~= nil then self.layout44:destroy(); self.layout44 = nil; end;
        if self.label21 ~= nil then self.label21:destroy(); self.label21 = nil; end;
        if self.edit11 ~= nil then self.edit11:destroy(); self.edit11 = nil; end;
        if self.button55 ~= nil then self.button55:destroy(); self.button55 = nil; end;
        if self.label61 ~= nil then self.label61:destroy(); self.label61 = nil; end;
        if self.edit84 ~= nil then self.edit84:destroy(); self.edit84 = nil; end;
        if self.edit25 ~= nil then self.edit25:destroy(); self.edit25 = nil; end;
        if self.layout77 ~= nil then self.layout77:destroy(); self.layout77 = nil; end;
        if self.layout34 ~= nil then self.layout34:destroy(); self.layout34 = nil; end;
        if self.rclMagias ~= nil then self.rclMagias:destroy(); self.rclMagias = nil; end;
        if self.label16 ~= nil then self.label16:destroy(); self.label16 = nil; end;
        if self.label24 ~= nil then self.label24:destroy(); self.label24 = nil; end;
        if self.edit16 ~= nil then self.edit16:destroy(); self.edit16 = nil; end;
        if self.button47 ~= nil then self.button47:destroy(); self.button47 = nil; end;
        if self.edit28 ~= nil then self.edit28:destroy(); self.edit28 = nil; end;
        if self.edit63 ~= nil then self.edit63:destroy(); self.edit63 = nil; end;
        if self.layout31 ~= nil then self.layout31:destroy(); self.layout31 = nil; end;
        if self.layout87 ~= nil then self.layout87:destroy(); self.layout87 = nil; end;
        if self.label54 ~= nil then self.label54:destroy(); self.label54 = nil; end;
        if self.tab9 ~= nil then self.tab9:destroy(); self.tab9 = nil; end;
        if self.edit50 ~= nil then self.edit50:destroy(); self.edit50 = nil; end;
        if self.button42 ~= nil then self.button42:destroy(); self.button42 = nil; end;
        if self.button31 ~= nil then self.button31:destroy(); self.button31 = nil; end;
        if self.layout27 ~= nil then self.layout27:destroy(); self.layout27 = nil; end;
        if self.edit137 ~= nil then self.edit137:destroy(); self.edit137 = nil; end;
        if self.layout82 ~= nil then self.layout82:destroy(); self.layout82 = nil; end;
        if self.label51 ~= nil then self.label51:destroy(); self.label51 = nil; end;
        if self.tab2 ~= nil then self.tab2:destroy(); self.tab2 = nil; end;
        if self.layout50 ~= nil then self.layout50:destroy(); self.layout50 = nil; end;
        if self.layout62 ~= nil then self.layout62:destroy(); self.layout62 = nil; end;
        if self.edit5 ~= nil then self.edit5:destroy(); self.edit5 = nil; end;
        if self.edit104 ~= nil then self.edit104:destroy(); self.edit104 = nil; end;
        if self.edit69 ~= nil then self.edit69:destroy(); self.edit69 = nil; end;
        if self.layout22 ~= nil then self.layout22:destroy(); self.layout22 = nil; end;
        if self.button36 ~= nil then self.button36:destroy(); self.button36 = nil; end;
        if self.label43 ~= nil then self.label43:destroy(); self.label43 = nil; end;
        if self.tab7 ~= nil then self.tab7:destroy(); self.tab7 = nil; end;
        if self.layout55 ~= nil then self.layout55:destroy(); self.layout55 = nil; end;
        if self.layout16 ~= nil then self.layout16:destroy(); self.layout16 = nil; end;
        if self.label30 ~= nil then self.label30:destroy(); self.label30 = nil; end;
        if self.button1 ~= nil then self.button1:destroy(); self.button1 = nil; end;
        if self.edit39 ~= nil then self.edit39:destroy(); self.edit39 = nil; end;
        if self.layout29 ~= nil then self.layout29:destroy(); self.layout29 = nil; end;
        if self.button48 ~= nil then self.button48:destroy(); self.button48 = nil; end;
        if self.layout69 ~= nil then self.layout69:destroy(); self.layout69 = nil; end;
        if self.edit79 ~= nil then self.edit79:destroy(); self.edit79 = nil; end;
        if self.edit45 ~= nil then self.edit45:destroy(); self.edit45 = nil; end;
        if self.edit110 ~= nil then self.edit110:destroy(); self.edit110 = nil; end;
        if self.edit128 ~= nil then self.edit128:destroy(); self.edit128 = nil; end;
        if self.layout13 ~= nil then self.layout13:destroy(); self.layout13 = nil; end;
        if self.label35 ~= nil then self.label35:destroy(); self.label35 = nil; end;
        if self.button4 ~= nil then self.button4:destroy(); self.button4 = nil; end;
        if self.edit32 ~= nil then self.edit32:destroy(); self.edit32 = nil; end;
        if self.edit117 ~= nil then self.edit117:destroy(); self.edit117 = nil; end;
        if self.layout5 ~= nil then self.layout5:destroy(); self.layout5 = nil; end;
        if self.edit93 ~= nil then self.edit93:destroy(); self.edit93 = nil; end;
        if self.edit72 ~= nil then self.edit72:destroy(); self.edit72 = nil; end;
        if self.edit40 ~= nil then self.edit40:destroy(); self.edit40 = nil; end;
        if self.layout79 ~= nil then self.layout79:destroy(); self.layout79 = nil; end;
        if self.label49 ~= nil then self.label49:destroy(); self.label49 = nil; end;
        if self.edit18 ~= nil then self.edit18:destroy(); self.edit18 = nil; end;
        if self.label2 ~= nil then self.label2:destroy(); self.label2 = nil; end;
        if self.button13 ~= nil then self.button13:destroy(); self.button13 = nil; end;
        if self.imageCheckBox2 ~= nil then self.imageCheckBox2:destroy(); self.imageCheckBox2 = nil; end;
        if self.button23 ~= nil then self.button23:destroy(); self.button23 = nil; end;
        if self.edit37 ~= nil then self.edit37:destroy(); self.edit37 = nil; end;
        if self.edit98 ~= nil then self.edit98:destroy(); self.edit98 = nil; end;
        if self.tabControl4 ~= nil then self.tabControl4:destroy(); self.tabControl4 = nil; end;
        if self.label19 ~= nil then self.label19:destroy(); self.label19 = nil; end;
        if self.layout40 ~= nil then self.layout40:destroy(); self.layout40 = nil; end;
        if self.edit126 ~= nil then self.edit126:destroy(); self.edit126 = nil; end;
        if self.label5 ~= nil then self.label5:destroy(); self.label5 = nil; end;
        if self.button14 ~= nil then self.button14:destroy(); self.button14 = nil; end;
        if self.button26 ~= nil then self.button26:destroy(); self.button26 = nil; end;
        if self.edit80 ~= nil then self.edit80:destroy(); self.edit80 = nil; end;
        if self.edit21 ~= nil then self.edit21:destroy(); self.edit21 = nil; end;
        if self.layout73 ~= nil then self.layout73:destroy(); self.layout73 = nil; end;
        if self.layout38 ~= nil then self.layout38:destroy(); self.layout38 = nil; end;
        if self.button59 ~= nil then self.button59:destroy(); self.button59 = nil; end;
        if self.tabControl3 ~= nil then self.tabControl3:destroy(); self.tabControl3 = nil; end;
        if self.label12 ~= nil then self.label12:destroy(); self.label12 = nil; end;
        if self.label20 ~= nil then self.label20:destroy(); self.label20 = nil; end;
        if self.edit12 ~= nil then self.edit12:destroy(); self.edit12 = nil; end;
        if self.button52 ~= nil then self.button52:destroy(); self.button52 = nil; end;
        if self.label60 ~= nil then self.label60:destroy(); self.label60 = nil; end;
        if self.edit87 ~= nil then self.edit87:destroy(); self.edit87 = nil; end;
        if self.edit24 ~= nil then self.edit24:destroy(); self.edit24 = nil; end;
        if self.edit67 ~= nil then self.edit67:destroy(); self.edit67 = nil; end;
        if self.layout35 ~= nil then self.layout35:destroy(); self.layout35 = nil; end;
        if self.button38 ~= nil then self.button38:destroy(); self.button38 = nil; end;
        if self.label17 ~= nil then self.label17:destroy(); self.label17 = nil; end;
        if self.label27 ~= nil then self.label27:destroy(); self.label27 = nil; end;
        if self.edit17 ~= nil then self.edit17:destroy(); self.edit17 = nil; end;
        if self.edit54 ~= nil then self.edit54:destroy(); self.edit54 = nil; end;
        if self.button46 ~= nil then self.button46:destroy(); self.button46 = nil; end;
        if self.label58 ~= nil then self.label58:destroy(); self.label58 = nil; end;
        if self.edit62 ~= nil then self.edit62:destroy(); self.edit62 = nil; end;
        if self.layout32 ~= nil then self.layout32:destroy(); self.layout32 = nil; end;
        if self.edit133 ~= nil then self.edit133:destroy(); self.edit133 = nil; end;
        if self.layout86 ~= nil then self.layout86:destroy(); self.layout86 = nil; end;
        if self.label55 ~= nil then self.label55:destroy(); self.label55 = nil; end;
        if self.edit51 ~= nil then self.edit51:destroy(); self.edit51 = nil; end;
        if self.button41 ~= nil then self.button41:destroy(); self.button41 = nil; end;
        if self.edit1 ~= nil then self.edit1:destroy(); self.edit1 = nil; end;
        if self.edit100 ~= nil then self.edit100:destroy(); self.edit100 = nil; end;
        if self.button32 ~= nil then self.button32:destroy(); self.button32 = nil; end;
        if self.layout26 ~= nil then self.layout26:destroy(); self.layout26 = nil; end;
        if self.edit140 ~= nil then self.edit140:destroy(); self.edit140 = nil; end;
        if self.edit136 ~= nil then self.edit136:destroy(); self.edit136 = nil; end;
        if self.layout81 ~= nil then self.layout81:destroy(); self.layout81 = nil; end;
        if self.label47 ~= nil then self.label47:destroy(); self.label47 = nil; end;
        if self.tab3 ~= nil then self.tab3:destroy(); self.tab3 = nil; end;
        if self.layout51 ~= nil then self.layout51:destroy(); self.layout51 = nil; end;
        if self.layout65 ~= nil then self.layout65:destroy(); self.layout65 = nil; end;
        if self.edit4 ~= nil then self.edit4:destroy(); self.edit4 = nil; end;
        if self.edit105 ~= nil then self.edit105:destroy(); self.edit105 = nil; end;
        if self.edit68 ~= nil then self.edit68:destroy(); self.edit68 = nil; end;
        if self.button37 ~= nil then self.button37:destroy(); self.button37 = nil; end;
        if self.edit139 ~= nil then self.edit139:destroy(); self.edit139 = nil; end;
        if self.label42 ~= nil then self.label42:destroy(); self.label42 = nil; end;
        if self.tab4 ~= nil then self.tab4:destroy(); self.tab4 = nil; end;
        if self.layout17 ~= nil then self.layout17:destroy(); self.layout17 = nil; end;
        if self.label31 ~= nil then self.label31:destroy(); self.label31 = nil; end;
        if self.layout68 ~= nil then self.layout68:destroy(); self.layout68 = nil; end;
        if self.edit113 ~= nil then self.edit113:destroy(); self.edit113 = nil; end;
        if self.layout28 ~= nil then self.layout28:destroy(); self.layout28 = nil; end;
        if self.layout9 ~= nil then self.layout9:destroy(); self.layout9 = nil; end;
        if self.edit76 ~= nil then self.edit76:destroy(); self.edit76 = nil; end;
        if self.edit44 ~= nil then self.edit44:destroy(); self.edit44 = nil; end;
        if self.edit129 ~= nil then self.edit129:destroy(); self.edit129 = nil; end;
        if self.layout10 ~= nil then self.layout10:destroy(); self.layout10 = nil; end;
        if self.label36 ~= nil then self.label36:destroy(); self.label36 = nil; end;
        if self.edit89 ~= nil then self.edit89:destroy(); self.edit89 = nil; end;
        if self.edit33 ~= nil then self.edit33:destroy(); self.edit33 = nil; end;
        if self.edit116 ~= nil then self.edit116:destroy(); self.edit116 = nil; end;
        if self.layout4 ~= nil then self.layout4:destroy(); self.layout4 = nil; end;
        if self.edit94 ~= nil then self.edit94:destroy(); self.edit94 = nil; end;
        if self.edit73 ~= nil then self.edit73:destroy(); self.edit73 = nil; end;
        if self.edit43 ~= nil then self.edit43:destroy(); self.edit43 = nil; end;
        if self.label48 ~= nil then self.label48:destroy(); self.label48 = nil; end;
        if self.edit122 ~= nil then self.edit122:destroy(); self.edit122 = nil; end;
        if self.edit19 ~= nil then self.edit19:destroy(); self.edit19 = nil; end;
        if self.label1 ~= nil then self.label1:destroy(); self.label1 = nil; end;
        if self.button10 ~= nil then self.button10:destroy(); self.button10 = nil; end;
        if self.imageCheckBox5 ~= nil then self.imageCheckBox5:destroy(); self.imageCheckBox5 = nil; end;
        if self.button22 ~= nil then self.button22:destroy(); self.button22 = nil; end;
        if self.edit34 ~= nil then self.edit34:destroy(); self.edit34 = nil; end;
        if self.edit99 ~= nil then self.edit99:destroy(); self.edit99 = nil; end;
        if self.layout47 ~= nil then self.layout47:destroy(); self.layout47 = nil; end;
        if self.edit127 ~= nil then self.edit127:destroy(); self.edit127 = nil; end;
        if self.label4 ~= nil then self.label4:destroy(); self.label4 = nil; end;
        if self.button15 ~= nil then self.button15:destroy(); self.button15 = nil; end;
        if self.button29 ~= nil then self.button29:destroy(); self.button29 = nil; end;
        if self.edit83 ~= nil then self.edit83:destroy(); self.edit83 = nil; end;
        if self.edit20 ~= nil then self.edit20:destroy(); self.edit20 = nil; end;
        if self.layout74 ~= nil then self.layout74:destroy(); self.layout74 = nil; end;
        if self.layout39 ~= nil then self.layout39:destroy(); self.layout39 = nil; end;
        if self.button56 ~= nil then self.button56:destroy(); self.button56 = nil; end;
        if self.tabControl2 ~= nil then self.tabControl2:destroy(); self.tabControl2 = nil; end;
        if self.richEdit2 ~= nil then self.richEdit2:destroy(); self.richEdit2 = nil; end;
        if self.label13 ~= nil then self.label13:destroy(); self.label13 = nil; end;
        if self.label23 ~= nil then self.label23:destroy(); self.label23 = nil; end;
        if self.edit13 ~= nil then self.edit13:destroy(); self.edit13 = nil; end;
        if self.edit58 ~= nil then self.edit58:destroy(); self.edit58 = nil; end;
        if self.button53 ~= nil then self.button53:destroy(); self.button53 = nil; end;
        if self.edit86 ~= nil then self.edit86:destroy(); self.edit86 = nil; end;
        if self.edit66 ~= nil then self.edit66:destroy(); self.edit66 = nil; end;
        if self.script ~= nil then self.script:destroy(); self.script = nil; end;
        if self.layout36 ~= nil then self.layout36:destroy(); self.layout36 = nil; end;
        if self.button39 ~= nil then self.button39:destroy(); self.button39 = nil; end;
        if self.tab12 ~= nil then self.tab12:destroy(); self.tab12 = nil; end;
        if self.label14 ~= nil then self.label14:destroy(); self.label14 = nil; end;
        if self.label26 ~= nil then self.label26:destroy(); self.label26 = nil; end;
        if self.label59 ~= nil then self.label59:destroy(); self.label59 = nil; end;
        if self.edit55 ~= nil then self.edit55:destroy(); self.edit55 = nil; end;
        if self.layout58 ~= nil then self.layout58:destroy(); self.layout58 = nil; end;
        if self.button45 ~= nil then self.button45:destroy(); self.button45 = nil; end;
        if self.edit61 ~= nil then self.edit61:destroy(); self.edit61 = nil; end;
        if self.layout33 ~= nil then self.layout33:destroy(); self.layout33 = nil; end;
        if self.edit144 ~= nil then self.edit144:destroy(); self.edit144 = nil; end;
        if self.edit132 ~= nil then self.edit132:destroy(); self.edit132 = nil; end;
        if self.layout85 ~= nil then self.layout85:destroy(); self.layout85 = nil; end;
        if self.label52 ~= nil then self.label52:destroy(); self.label52 = nil; end;
        if self.edit52 ~= nil then self.edit52:destroy(); self.edit52 = nil; end;
        if self.button40 ~= nil then self.button40:destroy(); self.button40 = nil; end;
        if self.layout61 ~= nil then self.layout61:destroy(); self.layout61 = nil; end;
        if self.edit101 ~= nil then self.edit101:destroy(); self.edit101 = nil; end;
        if self.button9 ~= nil then self.button9:destroy(); self.button9 = nil; end;
        if self.button33 ~= nil then self.button33:destroy(); self.button33 = nil; end;
        if self.dataLink1 ~= nil then self.dataLink1:destroy(); self.dataLink1 = nil; end;
        if self.layout21 ~= nil then self.layout21:destroy(); self.layout21 = nil; end;
        if self.label38 ~= nil then self.label38:destroy(); self.label38 = nil; end;
        if self.layout80 ~= nil then self.layout80:destroy(); self.layout80 = nil; end;
        if self.edit135 ~= nil then self.edit135:destroy(); self.edit135 = nil; end;
        if self.label46 ~= nil then self.label46:destroy(); self.label46 = nil; end;
        if self.edit141 ~= nil then self.edit141:destroy(); self.edit141 = nil; end;
        if self.layout56 ~= nil then self.layout56:destroy(); self.layout56 = nil; end;
        if self.layout64 ~= nil then self.layout64:destroy(); self.layout64 = nil; end;
        if self.edit7 ~= nil then self.edit7:destroy(); self.edit7 = nil; end;
        if self.edit106 ~= nil then self.edit106:destroy(); self.edit106 = nil; end;
        if self.edit138 ~= nil then self.edit138:destroy(); self.edit138 = nil; end;
        if self.label41 ~= nil then self.label41:destroy(); self.label41 = nil; end;
        if self.tab5 ~= nil then self.tab5:destroy(); self.tab5 = nil; end;
        if self.layout14 ~= nil then self.layout14:destroy(); self.layout14 = nil; end;
        if self.label32 ~= nil then self.label32:destroy(); self.label32 = nil; end;
        if self.button7 ~= nil then self.button7:destroy(); self.button7 = nil; end;
        if self.edit112 ~= nil then self.edit112:destroy(); self.edit112 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newDzA()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_DzA();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _DzA = {
    newEditor = newDzA, 
    new = newDzA, 
    name = "DzA", 
    dataType = "DATA_TYPE_AQUI", 
    formType = "sheetTemplate", 
    formComponentName = "form", 
    cacheMode = "none", 
    title = "Dementes e Árduos", 
    description=""};

DzA = _DzA;
Firecast.registrarForm(_DzA);
Firecast.registrarDataType(_DzA);

return _DzA;
