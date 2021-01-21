﻿using Appeon.DataStoreDemo.SqlServer.Services;
using DWNet.Data;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SnapObjects.Data;
using System;

namespace Appeon.DataStoreDemo.SqlServer.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class AddressController : ControllerBase
    {
        private readonly IAddressService _addressService;

        public AddressController(IAddressService addService)
        {
            _addressService = addService;
        }

        // GET api/Address/WinOpen
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IDataPacker> WinOpen()
        {
            var packer = new DataPacker();

            var stateProvince = _addressService.Retrieve("d_dddw_stateprovince");

            if (stateProvince.RowCount == 0)
            {
                return NotFound();
            }

            packer.AddDataStore("StateProvince", stateProvince);

            return packer;
        }

        // GET api/Address/RetrieveAddress
        [HttpGet("{provinceId}/{city}")]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IDataPacker> RetrieveAddress(int provinceId, string city)
        {
            var packer = new DataPacker();

            if (city == "$")
            {
                city = "%";
            }
            else
            {
                city = "%" + city + "%";
            }

            var addressData = _addressService.Retrieve("d_address", provinceId, city);

            if (addressData.RowCount == 0)
            {
                return NotFound();
            }

            packer.AddDataStore("Address", addressData);

            return packer;
        }

        // GET api/Address/RetrieveAddress
        // Use compress
        [HttpGet("{provinceId}/{city}")]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<string> RetrieveAddress_Compress(int provinceId, string city)
        {
            var addressData = _addressService.Retrieve("d_address", provinceId, city);

            if (addressData.RowCount == 0)
            {
                return NotFound();
            }

            var json = addressData.ExportPlainJson(false);

            return json;
        }

        // POST api/Address/SaveChanges
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<IDataPacker> SaveChanges(IDataUnpacker unpacker)
        {
            var status = string.Empty;

            var packer = new DataPacker();

            var detail = new DataStore("d_address_free");
            detail.ImportJson(unpacker.Raw);

            try
            {
                status = _addressService.Update(detail);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }

            packer.AddDataStore("Address", detail);
            packer.AddValue("Status", status);

            return packer;
        }

        // DELETE api/Address/DeleteAddressByKey
        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<IDataPacker> DeleteAddressByKey(IDataUnpacker unpacker)
        {
            var status = string.Empty;

            var packer = new DataPacker();
            var addressId = unpacker.GetValue<int>("arm1");

            try
            {
                status = _addressService.Delete("d_address_free", addressId);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }

            packer.AddValue("Status", status);

            return packer;
        }
    }
}