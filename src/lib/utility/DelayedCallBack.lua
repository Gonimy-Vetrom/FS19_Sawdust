--- Royal Utility

---@author Royal Modding
---@version 2.0.0.0
---@date 08/03/17

DelayedCallBack = {}

function DelayedCallBack:new(callBack, callBackSelf)
    if DelayedCallBack_mt == nil then
        DelayedCallBack_mt = Class(DelayedCallBack)
    end
    local dcb = {}
    setmetatable(dcb, DelayedCallBack_mt)
    dcb.callBack = callBack
    dcb.callBackSelf = callBackSelf
    dcb.callBackCalled = true
    dcb.delay = 0
    dcb.delayCounter = 0
    dcb.skipOneFrame = false
    return dcb
end

function DelayedCallBack:update(dt)
    if not self.callBackCalled then
        if not self.skipOneFrame then
            self.delayCounter = self.delayCounter + dt
        end
        if self.delayCounter >= self.delay then
            self:callCallBack()
        end
        if self.skipOneFrame then
            self.delayCounter = self.delayCounter + dt
        end
    end
end

function DelayedCallBack:call(delay, ...)
    self.callBackCalled = false
    self.otherParams = {...}
    if delay == nil or delay == 0 then
        self:callCallBack()
    else
        self.delay = delay
        self.delayCounter = 0
    end
end

function DelayedCallBack:callCallBack()
    if self.callBackSelf ~= nil then
        self.callBack(self.callBackSelf, unpack(self.otherParams))
    else
        self.callBack(unpack(self.otherParams))
    end
    self.callBackCalled = true
end
