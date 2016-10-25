--UEF ACU

local oldUEL0001 = UEL0001
UEL0001 = Class(oldUEL0001) {

	OnCreate = function(self)
		oldUEL0001.OnCreate(self)
		--ACUUnit.OnCreate(self)
		self:AddBuildRestriction(categories.CYBRAN + categories.AEON)
	end,
	
	CreateBuildEffects = function( self, unitBeingBuilt, order )
        local UpgradesFrom = unitBeingBuilt:GetBlueprint().General.UpgradesFrom
		local faction =  unitBeingBuilt:GetBlueprint().General.FactionName
		if faction == 'Cybran' then
			EffectUtil.SpawnBuildBots( self, unitBeingBuilt, self.BuildEffectsBag )
			EffectUtil.CreateCybranBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
		else
			--If we are assisting an upgrading unit, or repairing a unit, play separate effects
			if (order == 'Repair' and not unitBeingBuilt:IsBeingBuilt()) or (UpgradesFrom and UpgradesFrom ~= 'none' and self:IsUnitState('Guarding'))then
				EffectUtil.CreateDefaultBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
			else
				EffectUtil.CreateUEFCommanderBuildSliceBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )        
			end
		end
        
    end,
	
	-- cybran build effect
        --EffectUtil.SpawnBuildBots( self, unitBeingBuilt, self.BuildEffectsBag )
        --EffectUtil.CreateCybranBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )

    CreateEnhancement = function(self, enh)
        oldUEL0001.CreateEnhancement(self, enh)
		
		local bp = self:GetBlueprint().Enhancements[enh]
        if not bp then return end
		
        if enh =='CybranEngineering' then
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='CybranEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            self:AddBuildRestriction( categories.UEF * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            self:AddBuildRestriction( categories.UEF * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            self:AddBuildRestriction(categories.CYBRAN)
			self:AddBuildRestriction(categories.AEON)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
		elseif enh =='AeonEngineering' then
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='AeonEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            self:AddBuildRestriction( categories.UEF * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            self:AddBuildRestriction( categories.UEF * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            self:AddBuildRestriction(categories.CYBRAN)
			self:AddBuildRestriction(categories.AEON)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
		end
    end,
}

TypeClass = UEL0001