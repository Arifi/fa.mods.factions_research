--CYBRAN ACU

local oldURL0001 = URL0001
URL0001 = Class(oldURL0001) {

	OnCreate = function(self)
		oldURL0001.OnCreate(self)
		--ACUUnit.OnCreate(self)
		self:AddBuildRestriction(categories.SERAPHIM)
		self:AddBuildRestriction(categories.AEON)
		self:AddBuildRestriction(categories.UEF)
	end,
	
	CreateBuildEffects = function( self, unitBeingBuilt, order )
        local UpgradesFrom = unitBeingBuilt:GetBlueprint().General.UpgradesFrom
		local faction =  unitBeingBuilt:GetBlueprint().General.FactionName
		
		elseif faction == 'Aeon' then
			EffectUtil.CreateAeonCommanderBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
		elseif faction == 'UEF' then
			--If we are assisting an upgrading unit, or repairing a unit, play separate effects
			if (order == 'Repair' and not unitBeingBuilt:IsBeingBuilt()) or (UpgradesFrom and UpgradesFrom ~= 'none' and self:IsUnitState('Guarding'))then
				EffectUtil.CreateDefaultBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
			else
				EffectUtil.CreateUEFCommanderBuildSliceBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )        
			end
		elseif faction == 'Seraphim'
			EffectUtil.CreateSeraphimUnitEngineerBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
		else
			EffectUtil.SpawnBuildBots( self, unitBeingBuilt, self.BuildEffectsBag )
			EffectUtil.CreateCybranBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
		end
    end,
	
    CreateEnhancement = function(self, enh)
        oldURL0001.CreateEnhancement(self, enh)
		
		local bp = self:GetBlueprint().Enhancements[enh]
        if not bp then return end
		
        if enh =='SeraEngineering' then
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='SeraEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
			self:AddBuildRestriction(categories.SERAPHIM)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
			-- ***
		elseif enh =='AeonEngineering' then
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='AeonEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
			self:AddBuildRestriction(categories.AEON)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
		elseif enh =='UEFEngineering' then
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='UEFEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
			self:AddBuildRestriction(categories.UEF)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
			-- ***
			--
        elseif enh =='AdvancedEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            self:AddBuildRestriction( categories.CYBRAN * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            if Buff.HasBuff( self, 'CybranACUT2BuildRate' ) then
                Buff.RemoveBuff( self, 'CybranACUT2BuildRate' )
            end
			
			self:AddBuildRestriction(categories.SERAPHIM)
			self:AddBuildRestriction(categories.AEON)
			self:AddBuildRestriction(categories.UEF)
			--
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='T3EngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            if Buff.HasBuff( self, 'CybranACUT3BuildRate' ) then
                Buff.RemoveBuff( self, 'CybranACUT3BuildRate' )
            end
            self:AddBuildRestriction( categories.CYBRAN * ( categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
			--
			self:AddBuildRestriction(categories.SERAPHIM)
			self:AddBuildRestriction(categories.AEON)
			self:AddBuildRestriction(categories.UEF)
			--
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
		end
		
    end,
}

TypeClass = URL0001
