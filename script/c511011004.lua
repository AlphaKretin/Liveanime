--Tour of Doom (Anime)
--updated by GameMaster(GM)
function c511011004.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetHintTiming(0,TIMING_STANDBY_PHASE)
c:RegisterEffect(e1)
--coin
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(62784717,0))
e2:SetCategory(CATEGORY_COIN)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
e2:SetRange(LOCATION_SZONE)
e2:SetCountLimit(1)
e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
e2:SetCondition(c511011004.coincon)
e2:SetTarget(c511011004.cointg)
e2:SetOperation(c511011004.coinop)
c:RegisterEffect(e2)
end

function c511011004.coincon(e,tp,eg,ep,ev,re,r,rp)
return tp~=Duel.GetTurnPlayer()
end

function c511011004.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end

function c511011004.coinop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if not c:IsRelateToEffect(e) then return end
c:ResetFlagEffect(511011004)--reset coin flip description
local res=0
res=Duel.TossCoin(tp,1) 
c:RegisterFlagEffect(511011004,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,res,63-res)-- set hint to the coin flip
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetCode(EFFECT_CANNOT_SUMMON)
if res==0 then
e1:SetReset(RESET_PHASE+PHASE_END,2)
e1:SetTargetRange(1,0)
else
e1:SetReset(RESET_PHASE+PHASE_END)
e1:SetTargetRange(0,1)
end
Duel.RegisterEffect(e1,tp)
local e2=e1:Clone()
e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
Duel.RegisterEffect(e2,tp)
local e3=e1:Clone()
e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
Duel.RegisterEffect(e3,tp)
end

